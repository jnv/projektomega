# encoding: utf-8
module SharedExamples
  shared_examples_for "reports list" do
    scenario 'show available reports' do
      reports = FactoryGirl.create_list(:report, 2, {model_name => model})
      eval "visit #{model_name.to_s}_path(model)"

      page.should have_selector("h3", content: "Hlášení")

      reports.each do |report|
        within(css_dom_id(report)) do
          page.should have_link(report.send(link_subject).full_name)
        end
      end
    end
  end

  shared_examples_for "evaluations list" do
    before :each do
      evaluation # = FactoryGirl.create(:evaluation, {attended_mission: mission})
    end

    scenario 'show available evaluations' do
      eval "visit #{model_name.to_s}_path(model)"
      page.should have_selector("h3", content: "Hodnocení agentů")
      within("#evaluations") do
        page.should have_selector(css_dom_id(evaluation))
        page.should have_content(evaluation.author.full_name)
      end
    end

    scenario 'show link to new evaluations' do
      sign_in_with_admin
      eval "visit #{model_name.to_s}_path(model)"

      within("#evaluations") do
        page.should have_link("Přidat hodnocení")
      end
    end
  end
end

RSpec.configuration.include SharedExamples, type: :acceptance