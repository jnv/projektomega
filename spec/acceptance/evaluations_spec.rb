# encoding: utf-8
require 'acceptance/acceptance_helper'

feature 'Evaluations' do

  before do
    @evaluation = Factory(:evaluation)
    @mission = @evaluation.mission
    @author = @evaluation.author
    @character = @evaluation.character
  end

  scenario 'show evaluations' do
    visit evaluations_path

    page.should_not have_link("Nové hodnocení")

    within(css_dom_id(@evaluation)) do
      page.should have_link(@mission.full_name)
      page.should have_link(@character.full_name)
      page.should have_link(@author.full_name)
      page.should_not have_link("Upravit")
      click_link("Zobrazit")
    end

    #visit mission_attendance_path(@report)
    page.should have_link(@mission.full_name)
    page.should have_link(@character.full_name)
    page.should have_link(@author.full_name)
    page.should have_content @evaluation.content

  end

  context 'authorized user' do

    pending do
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
end