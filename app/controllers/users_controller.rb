class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit, :destroy, :update]

  def new
    @user = User.new
  end

  def index
    @user = User.where(trainer: true)
      # Rails.logger.debug params.inspect
      if params[:search]
        category = Category.find_by(:genre => params[:search])
        if category
          @user = category.users
        else
          if @user.count == 1
            redirect_to users_url(@user.first)
          end
        end
      else
        @user = User.all
      end
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
    #  @user = User.find(params[:id])
    client = Signet::OAuth2::Client.new(access_token: session[:access_token])

    client.expires_in = Time.now + 1_000_000
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    @calendar_list = service.list_calendar_lists #call something more useful (Docs)
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

  #Obtain an authorization code
  def redirect
    client = Signet::OAuth2::Client.new({
      client_id: ENV.fetch('SORCERY_GOOGLE_SECRET'),
      client_secret: ENV.fetch('SORCERY_GOOGLE_SECRET'),
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY,
      redirect_uri: 'http://phyziq.com:3000/oauth2callback'
    })
    redirect_to client.authorization_uri.to_s
  end

  #Obtain an access token
  def google_callback
    client = Signet::OAuth2::Client.new({
      client_id: ENV.fetch('SORCERY_GOOGLE_KEY'),
      client_secret: ENV.fetch('SORCERY_GOOGLE_SECRET'),
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      redirect_uri: 'http://phyziq.com:3000/oauth2callback',
      code: params[:code]
    })
    response = client.fetch_access_token!
    session[:access_token] = response['access_token']
    redirect_to url_for(:action => :show)
  end

private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :address, :trainer, :password, :password_confirmation)
  end
<<<<<<< HEAD

end
=======
# end
>>>>>>> d59c0e620961942bec3a4cb770c347cc70e1f804
