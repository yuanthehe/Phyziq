class OauthsController < ApplicationController
<<<<<<< HEAD
skip_before_filter :require_login

  # sends the user to the provider,
=======
  before_action :require_login, only: :destroy
  # sends the user on a trip to the provider,
>>>>>>> c6d30b9480d48a5b7a9358614342c0198acf7b81
  # and after authorizing there back to the callback url.
  def oauth
    login_at(params[:provider])
  end
<<<<<<< HEAD

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
    else
      begin
        @user = create_from(provider)
        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
      rescue
        redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
      end
    end
  end
=======
  # this is where all of the magic happens
  def callback
    provider = params[:provider]

    if @user = login_from(:google)
       # user has already linked their account with google
       # @user.google_access_token = @access_token.token
       flash[:alert] = "Logged in from Google!"
       redirect_to root_path
    # else
      # User has not linked their account with Google yet. If they are logged in,
      # authorize the account to be linked. If they are not logged in, require them
      # to sign in. NOTE: If you wanted to allow the user to register using oauth,
      # this section will need to be changed to be more like the wiki page that was
      # linked earlier.
      # if logged_in?
      #   link_account(:google)
      #   flash[:notice] = "Account linked from Google!"
      #   redirect_to user_path(@user)
    else
        @user = create_from(:google)
        reset_session # protect from session fixation attack
        auto_login(@user)
        flash[:alert] = 'Google account successfully linked!'
        redirect_to user_url(@user)
    end
  end

  def destroy
    provider = params[:provider]

    authentication = current_user.authentications.find_by_provider(provider)
    if authentication.present?
      authentication.destroy
      flash[:alert] = "You have successfully unlinked your #{provider.titleize} account."
    else
      flash[:alert] = "You do not currently have a linked #{provider.titleize} account."
    end
    redirect_to root_path
  end
>>>>>>> c6d30b9480d48a5b7a9358614342c0198acf7b81
end

#   private
#   def link_account(provider)
#     if @user = add_provider_to_user(provider)
#       If you want to store the user's Github login, which is required in order to interact with their Github account, uncomment the next line.
#       You will also need to add a 'github_login' string column to the users table.
#
#       @user.update_attribute(:google_login, @user_hash[:user_info]['login'])
#       flash[:notice] = "You have successfully linked your Google account."
#     else
#       flash[:alert] = "There was a problem linking your Google account."
#     end
#   end
#
#   def auth_params
#     params.permit(:provider, :code)
#   end
# end
