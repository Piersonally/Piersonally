class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      flash.notice = "Successfully signed in Through Google!"
      sign_in_and_redirect user
    else
      flash.alert = "There was a problem signing you in."
      redirect_to root_url
    end
  end
end
