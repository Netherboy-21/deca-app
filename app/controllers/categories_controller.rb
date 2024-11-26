class CategoriesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
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
