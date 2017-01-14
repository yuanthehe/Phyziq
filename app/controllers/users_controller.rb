class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit, :destroy, :update]

  def new
    @user = User.new
  end

  def index
    @user = User.where(trainer: true)
    # @category = Category.where(cross_fit: @user.ids)
    if params[:address].present?
      flash[:alert] = "Listing nearby trainers!"
      @user = User.near(params[:address], 5, units: :km).order("name ASC")
    elsif params[:search]
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
    if session[:access_token] != nil
      render :show
    else
      redirect_to :authorization_error
    end
  end

  def edit
    if @user.trainer == true && @user.category == nil
      @category = Category.create
      render :edit
    else
      @category = @user.category
      render :edit
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:alert] = "Account settings updated!"
      redirect_to user_url
    elsif @user.trainer == true && @user.category == nil
      render :edit
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :address, :bio, :latitude, :longitude, :trainer, :password, :password_confirmation,
    trainer_appointments_attributes: [:id, :summary, :event_start_time, :event_end_time, :event_invitation_status, :_destroy],
    trainee_appointments_attributes: [:id, :summary, :event_start_time, :event_end_time, :event_invitation_status, :_destroy])
  end

  def nearby_trainers
    @nearby_trainers = @user.where(trainer: true).nearbys(5, units: :km)
  end
end
