# encoding: utf-8
require 'features/features_helper'

feature 'Missions' do

  let(:mission) { FactoryGirl.create(:attended_mission) }

  scenario 'show all missions with agents' do
    mission
    visit missions_path

    within(css_dom_id(mission)) do
      page.should have_link(mission.name)

      mission.characters.each do |ch|
        page.should have_link(ch.code, href: character_path(ch))
      end
    end
  end

  it_should_behave_like "reports list" do
    let(:model) { mission }
    let(:model_name) { :mission }
    let(:link_subject) { :character }
  end

  it_should_behave_like "evaluations list" do
    let(:model) { mission }
    let(:model_name) { :mission }
    let(:evaluation) { FactoryGirl.create(:evaluation, {attended_mission: mission}) }
  end

  context 'unauthorized user' do
    scenario 'no new mission link on index' do
      visit missions_path
      page.should have_no_link("Vytvořit misi")
    end

    scenario 'no edit mission link on show' do
      visit mission_path(mission)
      page.should have_no_link("Upravit misi")
    end
  end

  context 'authorized user' do

    scenario 'link to new report' do
      attendance = FactoryGirl.create(:attendance, {mission: mission, report: nil})
      sign_in_with attendance.character.user

      visit mission_path(mission)
      #within(css_dom_id(attendance))
      within('.reports') do
        page.should have_link("Přidat hlášení")
      end
    end
  end

  context 'administrator' do

    before :each do
      @user = FactoryGirl.create(:admin)
      @mission = FactoryGirl.create(:mission)
      sign_in_with @user
      visit missions_path
    end

    scenario "should be able to edit any mission" do

      within(css_dom_id(@mission)) do
        click_link "Upravit"
      end

      fill_in 'Název', with: "My New Mission Name"

      click_button 'Uložit změny'

      should_be_on mission_path(@mission)
      page.should have_content("Mise byla upravena")

      page.should have_selector("h2", text: "My New Mission Name")

      page.should have_link("Upravit misi")

    end

    context "should be able to create new mission" do

      before :each do
        click_link "Nová mise"
      end

      scenario "with just number and name" do
        fill_in 'Číslo mise', with: '958'
        fill_in 'Název', with: 'Omaha Beach'

        click_button "Vytvořit"

        page.should have_content("Mise byla vytvořena")
      end

      scenario "with agents" do
        characters = FactoryGirl.create_list(:character, 3)
        reload

        characters.each do |ch|
          select ch.full_name, from: "Zúčastnění agenti"
        end

        fill_in 'Číslo mise', with: '958'
        fill_in 'Název', with: 'Omaha Beach'

        click_button "Vytvořit"

        page.should have_content("Mise byla vytvořena")
        page.should have_content("Zúčastnění agenti")
        characters.each do |ch|
          page.should have_content(ch.full_name)
        end
      end

    end
  end
end
