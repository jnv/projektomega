module Omega::DeviseAuth
  def authenticate
    if current_user
      ability = Ability.new(current_user)
      if ability.can?(:manage, "Cms::Site")
        true
      else
        raise CanCan::AccessDenied
      end
    else
      scope = Devise::Mapping.find_scope!(:user)
      session["#{scope}_return_to"] = new_cms_admin_site_path
      redirect_to new_user_session_path
    end
  end
end
