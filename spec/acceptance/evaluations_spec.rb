# encoding: utf-8
require 'acceptance/acceptance_helper'

feature 'Evaluations' do

  before do
    @mission = FactoryGirl.create(:attended_mission_w_users, attendees: 3) #@evaluation.mission
    @evaluation = FactoryGirl.create(:evaluation, {attended_mission: @mission})
    @author = @evaluation.author
    @character = @evaluation.character
    @character2 = @mission.characters[2]
                                                                #FactoryGirl.create(:evaluation, {attended_mission: @mission, character: @character2})
    @evaluation2 = FactoryGirl.create(:evaluation, {attended_mission: @mission, author: @character2, character: @character})

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

  context 'user (as author)' do
    before do
      sign_in_with @author.user
    end

    pending "Add selects to evaluation form" do
      scenario 'create a report' do
        visit mission_path(@mission)

        within("#evaluations_#{dom_id(MissionAttendance.last)}") do
          click_link("Přidat hodnocení")
        end

        within('form.evaluation') do
          fill_in "Obsah hodnocení", with: "Bad guy"
          click_button "Vytvořit"
        end

        page.should have_content "Bad guy"
      end
    end
  end

  context 'admin' do
    before do
      sign_in_with_admin
    end

    scenario 'create a report' do

    end
  end
end