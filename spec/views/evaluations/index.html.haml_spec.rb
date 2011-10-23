require 'spec_helper'

describe "evaluations/index.html.haml" do
  pending do
    before(:each) do
      assign(:evaluations, [
          stub_model(Evaluation),
          stub_model(Evaluation)
      ])
    end

    it "renders a list of evaluations" do
      render
    end
  end
end
