# encoding: utf-8
require 'acceptance/acceptance_helper'

feature 'Authentication' do

  before :each do
    @transactions_state = self.use_transactional_fixtures
    #self.use_transactional_fixtures = false
    @user = FactoryGirl.create(:user)
  end
  
  after :each do
    #self.use_transactional_fixtures = @transactions_state
  end


  scenario 'Registration' do
    visit sign_up_path
    within("#user_new") do
      fill_in 'Jméno', with: 'Leeroy Jenkins'
      fill_in 'E-mail', with: 'user@example.com'
      fill_in 'Heslo', with: 'please'
      fill_in 'user_password_confirmation', with: 'please'
      click_button 'Zaregistrovat se'
    end

    page.should have_content 'Registrace byla úspěšná.'
    click_link 'Odhlášení'
    page.should have_content 'Odhlášení úspěšné.'

  end

  scenario 'Login' do
    visit sign_in_path
    within "#user_new" do
      fill_in 'E-mail', with: @user.email
      fill_in 'Heslo', with: @user.password
      click_button 'Přihlásit se'
    end

    page.should have_content 'Přihlášení úspěšné.'
    page.should have_link 'Odhlášení'

  end

end
