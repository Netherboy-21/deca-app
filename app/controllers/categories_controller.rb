class CategoriesController < ApplicationController
  def index
    @user = session[:user_id]
    @categories = Category.where(user: @user)
  end

  def new
    @user = User.find(params[:user_id])
    @category = @user.categories.build
  end

  def create
    @user = User.find(params[:user_id])
    @category = @user.categories.new(category_params)
    if @category.save
      redirect_to user_app_transactions_path(params[:user_id])
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(session[:user_id])
    @category = Category.find(params[:id])
  end

  def update
    @user = User.find(session[:user_id])
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to user_categories_path(params[:user_id])
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def category_params
      params.expect(category: [ :name ])
    end
end
