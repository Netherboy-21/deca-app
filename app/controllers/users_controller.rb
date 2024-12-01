class UsersController < ApplicationController

  def home
    # Work in progress, just redirects the user
    if session[:user_id].nil?
      redirect_to login_path
    else
      redirect_to app_transactions_path
    end
  end

  def new
    # For the sign_up path
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
    if @user.save
      session[:user_id] = @user.id
      @user.categories.build(name: "Unsorted").save
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
      redirect_to sign_up_path
    end
  end
  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  private
    def sign_up_params
      params.expect(user: [ :username, :password, :email ])
    end

    def login_params
      params.expect(user: [ :password, :email ])
    end
end
