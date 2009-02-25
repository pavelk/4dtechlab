class UsersController < ApplicationController
  #before_filter :require_no_user, :only => [:new, :create, :registration]
  #before_filter :require_user, :only => [:show, :edit, :update, :change_password]
  skip_before_filter :check_authentication, :only => [:new, :create, :registration]
  
  layout :choose_layout
  
#  def sub_menu
#    "submenu_users"
#  end
  
  def sidebar_menu
    "sidebarmenu_users"
  end  
    
  def new
    add_crumb('Register') 
    @user = User.new
  end
  
  def index
    add_crumb('People')
    #@users = User.find(:all, :conditions => 'approved = false', :order => 'created_at DESC')
    @users = User.all(:order => 'created_at ASC', :conditions => ['approved = ?', '1']).paginate :per_page => 6, :page => params[:page]
    respond_to do |format|
      format.html
      format.xml  { render :xml => @users }
    end
  end

  def noapproved
    add_crumb('People')
    @users = User.all(:order => 'created_at ASC', :conditions => ['approved = ?', '0']).paginate :per_page => 6, :page => params[:page]
    render :action => "index"
  end
  
  def create
    @user = User.new(params[:user]) 
    if @user.save
      @user.roles << Role.find(2)
      flash[:notice] = "Account registered!"
      #redirect_back_or_default account_url
      #redirect_to root_url
      @user.deliver_init_mail_to_user
      @user.deliver_init_mail_to_admin
      redirect_to registration_user_path(@user)
    else
      #render :action => :new
      redirect_to new_user_path
    end
  end
  
  def registration
    #current_user_session.destroy
  end
  
  def show
    add_crumb('People', users_path)
    #@user = @current_user
    @user = User.find(params[:id])
    add_crumb("#{@user.full_name} profile")
  end 
 
  def edit
    @user = @current_user
    add_crumb("Editation - #{@user.full_name}")
  end
  
  def change_password
    @user = @current_user
    add_crumb("Change password - #{@user.full_name}")
  end  
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to user_path(@user)
    else
      render :action => :edit
    end
  end
  
  def approved
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      if(params[:user][:approved] == "1")
        flash[:notice] = "Account approved!"
        #poslat mail -> activate
      else
        flash[:notice] = "Account disabled!"
      end
      redirect_to user_path(@user)
    else
      render :action => :show
    end
  end
  
  def recent
    @users = User.new_registered
    add_crumb('People', users_path)
    add_crumb('New registered')
    render :action => "index" 
  end

  private
    def choose_layout    
      if [ 'new', 'registration' ].include? action_name
        'public'
      else
        'application'
      end
    end  
end
