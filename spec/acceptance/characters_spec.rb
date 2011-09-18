# encoding: utf-8
require 'acceptance/acceptance_helper'

feature 'Characters' do

  let :character do
    @character ||= Factory :character
    @character
  end

  scenario 'show agents for unregistered user' do
    char = character
    visit characters_path

    find("#characters") do |chars|
      chars.should have_link(char.full_name)
      chars.should have_content(char.user.name)
    end
    page.should have_no_link("Vytvořit agenta", href: new_character_path)

  end


  describe 'authorized user' do

    before :each do
      @user = Factory :user
      @char = Factory(:character, user: @user)
      sign_in_with @user
      visit characters_path
    end

    scenario 'should be able to edit his character' do

      find(css_dom_id(@char)) do |char|
        char.should have_content(@user.name)
        char.should have_link(@char.full_name)
      end

      within(css_dom_id(@char)) do
        click_link "Upravit"
      end

      
    end

  end

end
