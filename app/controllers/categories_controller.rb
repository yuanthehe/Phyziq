class CategoriesController < ApplicationController
  before_action :load_user, only: [:show, :edit, :destroy, :update]
  before_action :load_category, only: [:show, :edit, :destroy, :update]

  def new
    @category = @user.category.build
  end

  def index
    @user = User.where(trainer: true)
    @category = Category.where(user_id: :user_id)
  end

  def create
    @category = @user.build_category(category_params)
    @category.user_id = current_user.id

    if @category.save
      redirect_to user_url(@user)
    else
      render edit_user_path(@user)
    end
  end

  def edit

  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:alert] = "Training Categories Updated!"
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

  def load_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:user_id, :weightlifting, :crossfit,
    :yoga, :cardio, :running, :squash, :boxing, :kickboxing)
  end
end
