require 'spec_helper'

describe "evaluations/edit.html.haml" do
  pending do
    before(:each) do
      @evaluation = assign(:evaluation, stub_model(Evaluation))
    end

    it "renders the edit evaluation form" do
      render

      # Run the generator again with the --webrat flag if you want to use webrat matchers
      assert_select "form", :action => evaluations_path(@evaluation), :method => "post" do
      end
    end
  end
end
