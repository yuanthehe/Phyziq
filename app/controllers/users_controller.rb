class UsersController < ApplicationController

  before_action :load_user, only: [:show, :edit, :destroy, :update]

  def new
    @user = User.new
  end

  def index
    @user = User.where(trainer: true)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      if @user.trainer == true
        redirect_to user_url(@user)
      else
        redirect_to users_url
      end
    else
      render 'new'
    end
  end

  def show
  #  @user = User.find(params[:id])
  end

  def edit
  #  @user = User.find(params[:id])
  end

  def update
  #  @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_url
    else
      render :edit
    end
  end

  def destroy
  #  @user = User.find(params[:id])
    @user.destroy
    redirect_to :new
  end

private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :address, :trainer)
  end
end
