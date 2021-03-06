# encoding: utf-8
require 'features/features_helper'

feature 'Reports' do

  before do
    @report = FactoryGirl.create(:report)
    @user = @report.character.user
  end

  scenario 'show reports' do
    visit mission_attendances_path

    within(css_dom_id(@report)) do
      page.should have_link(@report.mission.full_name)
      page.should have_link(@report.character.full_name)
      page.should_not have_link("Upravit")
      click_link("Zobrazit")
    end

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

      #save_and_open_page
      fill_in "Obsah hlášení", with: "It all started one rainy night."

      click_button "Uložit změny"

      page.should have_content "It all started one rainy night."
    end
  end
end
