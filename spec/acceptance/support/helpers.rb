# encoding: utf-8
module HelperMethods
  # Put helper methods you need to be available in all acceptance specs here.

  def sign_in_with(user)
    visit sign_in_path
    within "#new_user" do
      fill_in 'E-mail', with: user.email
      fill_in 'Heslo', with: user.password
      click_button 'Přihlásit se'
    end
  end

  def sign_in_with_admin
    sign_in_with Factory(:admin)
  end

  [:notice, :error].each do |name|
    define_method "should_have_#{name}" do |message|
      page.should have_css(".message.#{name}", :text => message)
    end
  end

  def should_be_on(path)
    page.current_url.should match(/#{Regexp.escape(path)}$/)
  end

  def should_not_be_on(path)
    page.current_url.should_not match(/#{Regexp.escape(path)}$/)
  end

  def access_should_be_denied
    page.should have_content I18n.t('unauthorized.default_message')
  end

  def reload
    visit current_path
    #case Capybara::current_driver
    #  when :selenium
    #    visit page.driver.browser.current_url
    #  when :racktest
    #    visit [current_path, page.driver.last_request.env['QUERY_STRING']].reject(&:blank?).join('?')
    #  when :culerity
    #    page.driver.browser.refresh
    #  else
    #    raise "unsupported driver, use rack::test or selenium/webdriver"
    #end
  end

end

RSpec.configuration.include HelperMethods, :type => :acceptance