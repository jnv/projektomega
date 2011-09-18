# encoding: utf-8
module HelperMethods
  # Put helper methods you need to be available in all acceptance specs here.

  def sign_in_with(user)
    visit sign_in_path
    within "#user_new" do
      fill_in 'E-mail', with: user.email
      fill_in 'Heslo', with: user.password
      click_button 'Přihlásit se'
    end
  end

  [:notice, :error].each do |name|
    define_method "should_have_#{name}" do |message|
      page.should have_css(".message.#{name}", :text => message)
    end
  end

  def should_be_on(path)
    page.current_url.should match(Regexp.new(path))
  end

  def should_not_be_on(path)
    page.current_url.should_not match(Regexp.new(path))
  end

  include ActionController::RecordIdentifier
  def css_dom_id(record)
    "##{dom_id(record)}"
  end

end

RSpec.configuration.include HelperMethods, :type => :acceptance