require 'spec_helper'

describe "evaluations/show.html.haml" do
  pending do
    before(:each) do
      @evaluation = assign(:evaluation, stub_model(Evaluation))
    end

    it "renders attributes in <p>" do
      render
    end
  end
end
