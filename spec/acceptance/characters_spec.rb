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

      fill_in 'Jméno', with: "My New Name"
      fill_in 'Číslo agenta', with: '9947'

      click_button 'Uložit změny'

      page.should have_content("Agent byl upraven")
      should_be_on character_path(@char)

      find(".character_details") do |char|
        char.should have_content("My New Name")
        char.should_not have_content("9947")
      end
    end

    scenario "shouldn't be able to create new character" do
      pending "Finalize 'access denied' message" do
        access_should_be_denied
      end
    end

    scenario "shouldn't be able to edit someone else's character" do
      char2 = Factory(:character)
      visit characters_path
      find(css_dom_id(char2)) do |char|
        char.should_not have_link "Upravit"
      end
      visit character_path(char2)
      pending "Finalize 'access denied' message" do
        access_should_be_denied
      end
    end
  end

  describe 'authorized user' do

    before :each do
      @user = Factory :admin
      @char = Factory(:orphaned_character)
      sign_in_with @user
      visit characters_path
    end

    scenario "should be able to edit any character" do
      
    end

  end


end
