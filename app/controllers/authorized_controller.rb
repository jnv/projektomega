### Via https://github.com/plataformatec/devise/wiki/How-To:-Use-CanCan-+-Devise,-The-easy-way.

class AuthorizedController < ApplicationController

  #before_filter :authenticate_user!
  #enable_authorization
  enable_authorization do |exception|
    redirect_url = new_session_path(:user)

    if user_signed_in?
      redirect_url = root_url
    end
    ###XXX report to hoptoad
    redirect_to redirect_url, :alert => exception.message
  end

  load_and_authorize_resource

end