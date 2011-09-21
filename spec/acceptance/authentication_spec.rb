# encoding: utf-8
require 'acceptance/acceptance_helper'

feature 'Authentication' do

  let :user do
    Factory :user
  end

  before :each do
    #@transactions_state = self.use_transactional_fixtures
    #self.use_transactional_fixtures = false
    #@user = FactoryGirl.create(:user)
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

  end

  scenario 'Login and logout' do
    sign_in_with user
    should_be_on homepage
    page.should have_content 'Přihlášení úspěšné.'
    click_link 'Odhlášení'
    page.should have_content 'Odhlášení úspěšné.'
  end

  scenario 'Invalid login' do
    sign_in_with Factory.build(:user)
    should_be_on sign_in_path
    page.should have_content 'Neplatný e-mail nebo heslo'
  end

end
