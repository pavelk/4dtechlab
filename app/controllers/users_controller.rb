class UsersController < ApplicationController
  skip_before_filter :check_authentication, :only => [:new, :create, :registration]
  before_filter :load_tags, :only => [:show, :index, :tag, :noapproved]
  
  layout :choose_layout
  
#  def sub_menu
#    "submenu_users"
#  end
  def tag
    @tag = User.find_tagged_with(params[:id])
  end
  
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
    @users = User.all(:order => 'created_at ASC', :conditions => ['approved = ?', '1']).paginate :per_page => 15, :page => params[:page]
    respond_to do |format|
      format.html
      format.xml  { render :xml => @users }
    end
  end

  def noapproved
    add_crumb('People')
    @users = User.all(:order => 'created_at ASC', :conditions => ['approved = ?', '0']).paginate :per_page => 15, :page => params[:page]
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
    @user.tag_list = "#{@user.country}, #{@user.agency}, #{@user.user_position}"
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
        @user.deliver_activation_info_to_user
        flash[:notice] = "Account approved!"
        #poslat mail -> activate
      else
        @user.deliver_deactivation_info_to_user
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
    def load_tags
      @tags = User.tag_counts # returns all the tags used
    end  
    
    def choose_layout    
      if [ 'new', 'registration' ].include? action_name
        'public'
      else
        'application'
      end
    end  
end
