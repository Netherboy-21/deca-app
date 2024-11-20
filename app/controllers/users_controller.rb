class UsersController < ApplicationController

  def home
    if session[:user_id].nil?
      redirect_to login_path
    else
      @id = session[:user_id]
      @user = User.find(session[:user_id])
    end
  end

  def show
    @user = User.find(params[:id])
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

  def login
    if request.request_method == "GET"
      @user = User.new
    elsif request.request_method == "POST"
      if User.where(email: params[:user][:email], password: params[:user][:password]).exists?
        @user = User.find_by(email: params[:user][:email])
        session[:user_id] = @user.id
        redirect_to root_path
      else
        redirect_to '/sign_up'
      end
    end
  end

  private
  def user_params
    params.expect(user: [ :username, :password, :email ])
  end
end
