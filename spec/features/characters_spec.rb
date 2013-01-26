# encoding: utf-8
require 'features/features_helper'

feature 'Characters' do

  let(:character) { FactoryGirl.create(:character) }

  scenario 'show agents for unregistered user' do
    char = character
    visit characters_path

    find("#characters") do |chars|
      chars.should have_link(char.full_name)
      chars.should have_content(char.user.name)
    end
    page.should have_no_link("Vytvořit agenta", href: new_character_path)

  end

  scenario "show agent's missions" do
    attendances = FactoryGirl.create_list(:mission_attendance, 2, {character: character})
    visit character_path(character)

    find(".attendances") do |m|
      attendances.each do |a|
        m.should have_link(a.mission.full_name)
      end
    end
  end

  it_should_behave_like "reports list" do
    let(:model) { character }
    let(:model_name) { :character }
    let(:link_subject) { :mission }
  end

  it_should_behave_like "evaluations list" do
    let(:model) { character }
    let(:model_name) { :character }
    let(:evaluation) do
      extra_character = FactoryGirl.create(:orphaned_character)
      mission = FactoryGirl.create(:mission, characters: [character, extra_character])
      FactoryGirl.create(:evaluation, {mission: mission, character: character, author: extra_character})
    end
  end


  describe 'authorized user' do

    before :each do
      @user = FactoryGirl.create(:user)
      @char = FactoryGirl.create(:character, user: @user)
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
      file = Rails.root + 'spec/fixtures/images/portrait.jpg'
      attach_file 'Podobizna', file

      click_button 'Uložit změny'

      should_be_on character_path(@char)
      page.should have_content("Agent byl upraven")

      find(".description") do |char|
        page.should have_xpath("//img[contains(@src, \"uploads/\")]")
        char.should have_content("My New Name")
      end


    end

    scenario "shouldn't be able to create new character" do
      visit new_character_path
      access_should_be_denied
    end

    scenario "shouldn't be able to edit someone else's character" do
      char2 = FactoryGirl.create(:character)
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
      @user = FactoryGirl.create(:admin)
      @char = FactoryGirl.create(:orphaned_character)
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

      find(".attributes") do |char|
        char.should have_content("My New Name")
      end

      page.should have_link("Upravit agenta")

    end

    describe "should be able to create new character" do

      scenario "with just number and name" do
        click_link 'Nový agent'
        fill_in 'Číslo agenta', with: '958'
        fill_in 'Jméno', with: 'Agent Gadget'

        click_button "Vytvořit"

        page.should have_content("Agent byl vytvořen")
      end

    end
  end
end
