module Requests
  module NavigationHelpers
    # Put helper methods related to the paths in your application here.

    def homepage
      "/"
    end

    def sign_up_path
      new_user_registration_path
    end

    def sign_in_path
      new_user_session_path
    end
  end
end
RSpec.configuration.include Requests::NavigationHelpers, type: :feature
