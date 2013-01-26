# encoding: utf-8
require 'features/features_helper'

feature 'Home page', %q{
  As an unregistered user
  I want to see the home page
} do

  scenario 'Home page' do
    visit homepage
    page.should have_content('Projekt Omega')
    page.should have_link('Přihlásit')
    page.should have_link('Registrace')
    page.should have_link('Agenti')
    page.should have_link('Mise')
  end

end
