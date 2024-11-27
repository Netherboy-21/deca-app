class CategoriesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
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

  private
  def category_params
    params.expect(category: [ :name ])
  end
end
