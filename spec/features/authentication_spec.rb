# encoding: utf-8
require 'features/features_helper'

feature 'Authentication' do

  let(:user) { FactoryGirl.create(:user) }

  scenario 'Registration' do
    visit sign_up_path
    within("#new_user") do
      fill_in 'Jméno', with: 'Leeroy Jenkins'
      fill_in 'E-mail', with: 'user@example.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button 'Zaregistrovat se'
    end

    page.should have_content 'Registrace byla úspěšná.'

  end

  scenario 'Login and logout' do
    sign_in_with user
    should_be_on homepage
    page.should have_content 'Přihlášení úspěšné.'
    click_link 'Odhlásit'
    page.should have_content 'Odhlášení úspěšné.'
  end

  scenario 'Invalid login' do
    sign_in_with FactoryGirl.build(:user)
    should_be_on sign_in_path
    page.should have_content 'Neplatný e-mail nebo heslo'
  end

end
