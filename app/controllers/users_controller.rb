class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create, :log_in, :log_in_page]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

  def log_in_page
  end

  def log_in
    user = User.find_by email: params[:Email]
    if user.authenticate(params[:Password])
      session[:user_id] = user.id
      redirect_to action:'show', id:user.id 
    else 
      flash[:login_error] = "Invalid email and password combination."
      redirect_to action: 'log_in_page'
    end
  end

  def log_out 
    session.destroy
    redirect_to action: 'log_in_page'
  end

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.valid? 
      @user.save
      session[:user_id] = @user.id
      redirect_to action: 'show', id: @user.id 
    else 
      flash[:errors] = @user.errors.full_messages
      redirect_to action: 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to action: 'show', id: @user.id 
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to action: 'edit', id: @user.id
    end
  end

  def destroy
    User.destroy(params[:id])
    session.destroy
    redirect_to action: 'log_in'
  end

  private 
  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
