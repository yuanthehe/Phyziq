class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit, :destroy, :update]

  def new
    @user = User.new
    @user.build_category
  end

  def index
    @user = User.where(trainer: true)
      if params[:search]
        @user = User.search(params[:search]).order("name ASC")
      else
        @user = User.all
      end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      if @user.trainer == true
        auto_login(@user)
        flash[:alert] = "Trainer signed up!"
        redirect_to user_url(@user)
      else
        auto_login(@user)
        flash[:alert] = "Trainee signed up!"
        redirect_to users_url
      end
    else
      flash[:alert] = "Failed to signed up!"
      render 'new'
    end
  end

  def show
    # @user = User.find(params[:id])
    if session[:access_token] != nil
      render :show
    else
      redirect_to :authorization_error
    end
  end

  def edit
  #  @user = User.find(params[:id])
    if current_user
      @category = @user.category
    end

  end

  def update
  #  @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:alert] = "Account settings updated!"
      redirect_to user_url
    elsif @user.trainer == true && @user.category == nil
      redirect_to :edit
    else
      render :edit
    end
  end

  def destroy
  #  @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :address, :trainer, :password, :password_confirmation,
    trainer_appointments_attributes: [:id, :summary, :event_start_time, :event_end_time, :event_invitation_status, :_destroy],
    trainee_appointments_attributes: [:id, :summary, :event_start_time, :event_end_time, :event_invitation_status, :_destroy])
  end
end
