class CategoriesController < ApplicationController
  before_action :load_user

  def new
    @category = Category.new
    @user.category.build
  end

  def create
    @category = @user.build_category(category_params)
    @category.user_id = current_user.id

    if @category.save
      redirect_to user_url(@user), notice: 'Profile updated successfully'
    else
      render edit_user_path(@user)
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
  #  @user = User.find(params[:id])
  @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:alert] = "Settings updated!"
      redirect_to user_url(@user)
    else
      render :edit
    end
  end

  def destroy

  end

private

  def load_user
    @user = User.find(params[:user_id])
  end

  def category_params
    params.require(:category).permit(:user_id, :weight_lifting, :cross_fit,
    :yoga, :cardio, :running, :squash, :boxing, :martial_arts)
  end
end
