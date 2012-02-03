# encoding: utf-8
require 'acceptance/acceptance_helper'

feature 'Characters' do

  let(:character) { Factory :character }

  scenario 'show agents for unregistered user' do
    char = character
    visit characters_path

    find("#characters") do |chars|
      chars.should have_link(char.full_name)
      chars.should have_content(char.user.name)
    end
    page.should have_no_link("Vytvořit agenta", href: new_character_path)

  end

  it_should_behave_like "reports list" do
    let(:model) { character }
    let(:model_name) { :character }
  end

  it_should_behave_like "evaluations list" do
    let(:model) { character }
    let(:model_name) { :character }
    let(:evaluation) do
      extra_character = Factory(:orphaned_character)
      mission = Factory(:mission, characters: [character, extra_character])
      Factory(:evaluation, {mission: mission, character: character, author: extra_character})
    end
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
      file = Rails.root + 'spec/fixtures/images/portrait.jpg'
      attach_file 'Podobizna', file

      click_button 'Uložit změny'

      should_be_on character_path(@char)
      page.should have_content("Agent byl upraven")

      find(".character_details") do |char|
        page.should have_xpath("//img[contains(@src, \"uploads/\")]")
        char.should have_content("My New Name")
        char.should_not have_content("9947")
      end


    end

    scenario "shouldn't be able to create new character" do
      visit new_character_path
      access_should_be_denied
    end

    scenario "shouldn't be able to edit someone else's character" do
      char2 = Factory(:character)
      visit characters_path
      find(css_dom_id(char2)) do |char|
        char.should_not have_link "Upravit"
      end
      visit character_path(char2)
      page.should_not have_content("Upravit agenta")

      visit edit_character_path(char2)
      access_should_be_denied
    end

    scenario "should be able to upload agent's portrait" do
      pending
    end

  end

  describe 'administrator' do

    before :each do
      @user = Factory :admin
      @char = Factory :orphaned_character
      sign_in_with @user
      visit characters_path
    end

    scenario "should be able to edit any character" do

      within(css_dom_id(@char)) do
        click_link "Upravit"
      end

      fill_in 'Jméno', with: "My New Name"

      click_button 'Uložit změny'

      should_be_on character_path(@char)
      page.should have_content("Agent byl upraven")

      find(".character_details") do |char|
        char.should have_content("My New Name")
      end

      page.should have_link("Upravit agenta")

    end

    describe "should be able to create new character" do

      scenario "with just number and name" do
        click_link "Vytvořit agenta"
        fill_in 'Číslo agenta', with: '958'
        fill_in 'Jméno', with: 'Agent Gadget'

        click_button "Vytvořit"

        page.should have_content("Agent byl vytvořen")
      end

      scenario "but not without name or number" do

        click_link "Vytvořit agenta"
        fill_in "Číslo agenta", with: "abc"
        click_button "Vytvořit"

        page.should have_selector('p.inline-errors')
        fill_in "Číslo agenta", with: "13"
        click_button "Vytvořit"

        page.should have_selector('p.inline-errors')

        fill_in "Jméno", with: "Pinkie Pie"
        click_button "Vytvořit"

        page.should have_content("Agent byl vytvořen")
      end

    end
  end
end
