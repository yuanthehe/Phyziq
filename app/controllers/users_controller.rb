class UsersController < ApplicationController

  before_action :load_user

  def new
    @user = User.new
  end

  def index
    @user = User.where(trainer: true)
  end

  def create
    if @user.save
      if @user.trainer == true
        redirect_to 'show'
      else
        redirect_to 'index'
      end
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to user_url
    else
      render :edit
    end
  end

  def destroy
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
