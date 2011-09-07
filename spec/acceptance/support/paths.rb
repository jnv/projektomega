module NavigationHelpers
  # Put helper methods related to the paths in your application here.

  def homepage
    "/"
  end

  def registration
    new_user_registration_path
  end
end

RSpec.configuration.include NavigationHelpers, :type => :acceptance