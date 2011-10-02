# encoding: utf-8
require 'acceptance/acceptance_helper'

feature 'Reports' do

  before do
    @report = Factory(:report)
    @user = @report.character.user
  end

  scenario 'show reports' do

    visit mission_attendances_path
    #page.should have_selector('#mission_attendances')
    #find(css_dom_id(@report)) do |reports|
    save_and_open_page
    find('#mission_attendances') do |reports|
      reports.should have_link(@report.mission.full_name)
      reports.should have_link(@report.character.full_name)
      reports.should_not have_link("Upravit")
    end
    click_link("Zobrazit")

    #visit mission_attendance_path(@report)
    page.should have_content @report.report

  end

  context 'authorized user' do

    scenario 'edit own report' do
      sign_in_with @user
      visit mission_attendances_path

      within('#mission_attendances') do
        click_link("Upravit")
      end

      p page.current_url

      #save_and_open_page
      fill_in "Obsah hlášení", with: "It all started one rainy night."

      click_button "Uložit změny"

      page.should have_content "It all started one rainy night."
    end
  end
end
