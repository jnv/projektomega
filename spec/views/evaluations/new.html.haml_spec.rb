require 'spec_helper'

describe "evaluations/new.html.haml" do
  pending do
    before(:each) do
      assign(:evaluation, stub_model(Evaluation).as_new_record)
    end

    it "renders new evaluation form" do
      render

      # Run the generator again with the --webrat flag if you want to use webrat matchers
      assert_select "form", :action => evaluations_path, :method => "post" do
      end
    end
  end
end
