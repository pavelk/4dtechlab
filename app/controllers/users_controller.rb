class UsersController < ApplicationController
  #before_filter :require_no_user, :only => [:new, :create, :registration]
  #before_filter :require_user, :only => [:show, :edit, :update, :change_password]
  skip_before_filter :check_authentication, :only => [:new, :create, :registration]
  
  def sub_menu
    "submenu_users"
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
    @users = User.find(:all, :order => 'created_at DESC')

    respond_to do |format|
      format.html
      format.xml  { render :xml => @blogs }
    end
  end 
  
  def create
    @user = User.new(params[:user]) 
    #@user.person = Person.new
    if @user.save
      flash[:notice] = "Account registered!"
      #redirect_back_or_default account_url
      redirect_to root_url
      #redirect_to registration_user_path(@user)
    else
      render :action => :new
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
  end
  
  def change_password
    @user = @current_user
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
  
  def recent
    @users = User.new_registered
    add_crumb('People', users_path)
    add_crumb('New registered')
    render :action => "index" 
  end  
end
