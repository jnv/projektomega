# encoding: utf-8
module SharedExamples
  shared_examples_for "reports list" do
    scenario 'show available reports' do
      reports = FactoryGirl.create_list(:report, 2, {model_name => model})
      eval "visit #{model_name.to_s}_path(model)"

      page.should have_selector("h3", content: "Hlášení")

      reports.each do |report|
        within(css_dom_id(report)) do
          page.should have_link("Celé hlášení")
        end
      end
    end
  end

  shared_examples_for "evaluations list" do
    scenario 'show available evaluations' do
      evaluation # = Factory(:evaluation, {attended_mission: mission})
      eval "visit #{model_name.to_s}_path(model)"

      page.should have_selector("h3", content: "Hodnocení agentů")
      within("#evaluations") do
        page.should have_content(evaluation.character.full_name)
        page.should have_content(evaluation.author.full_name)
      end
    end
  end
end

RSpec.configuration.include SharedExamples, :type => :acceptance