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
    @category = @user.categories.new(category_params_with_user_id)
    if @category.save
      redirect_to categories_path
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
    if @category.update(category_params_with_user_id)
      redirect_to categories_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def category_params # Data from form
      params.expect(category: [ :name ])
    end

    def category_params_with_user_id # Data from form and user id
      category_params.merge(user_id: session[:user_id])
    end
end
