class UsersController < ApplicationController

  def home
    if session[:user_id].nil?
      redirect_to login_path
    else
      redirect_to user_app_transactions_path User.find(session[:user_id])
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def login_get
    @user = User.new
  end

  def login_post
    if User.where(login_params).exists?
      @user = User.find_by(login_params)
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to "/sign_up"
    end
  end
  def logout
    session[:user_id] = nil
    redirect_to "/"
  end

  private
  def user_params
    params.expect(user: [ :username, :password, :email ])
  end

  private
  def login_params
    params.expect(user: [ :password, :email ])
  end
end
