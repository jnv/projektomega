# encoding: utf-8
require 'acceptance/acceptance_helper'

feature 'Registration', %q{
  As an unregistered user
  I want to be able to sign-up
} do

  scenario 'Register with correct credentials' do
    visit registration
    within("#user_new") do
      fill_in 'Jméno', with: 'Leeroy Jenkins'
      fill_in 'E-mail', with: 'user@example.com'
      fill_in 'Heslo', with: 'please'
      fill_in 'user_password_confirmation', with: 'please'
      click_button 'Zaregistrovat se'
    end

    page.should have_content 'Registrace byla úspěšná.'
    
  end

end
