# encoding: utf-8
require 'acceptance/acceptance_helper'

feature 'Missions' do

  let(:mission) { Factory :mission }

  scenario 'show missions for unregistered user' do
    m = mission
    visit missions_path

    find("#missions") do |missions|
      missions.should have_link(m.name)
    end
    page.should have_no_link("Vytvořit misi", href: new_mission_path)

  end

  context 'administrator' do

    before :each do
      @user = Factory :admin
      @mission = Factory :mission
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

      page.should have_selector("h2", content: "My New Mission Name")

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

      scenario "but not without name or number" do
        fill_in "Číslo mise", with: "abc"
        click_button "Vytvořit"

        page.should have_selector('p.inline-errors')
        fill_in "Číslo mise", with: "13"
        click_button "Vytvořit"

        page.should have_selector('p.inline-errors')

        fill_in "Název", with: "Cutie Mark Crusaders"
        click_button "Vytvořit"

        page.should have_content("Mise byla vytvořena")
      end

    end
  end
end
