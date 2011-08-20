#Via: https://github.com/plataformatec/devise/wiki/How-To:-Use-CanCan-+-Devise,-The-easy-way.

class AuthorizedController < ApplicationController

  before_filter :authenticate_user!
  enable_authorization
  load_and_authorize_resource
  
end