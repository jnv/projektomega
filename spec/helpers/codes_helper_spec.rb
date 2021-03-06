require 'spec_helper'

describe CodesHelper do
  describe "linked_codes" do
    let(:model) do
      model = stub_model(Character)
      model.stub(:id) { 1 }
      model.stub(:code) { 'A' }
      model
    end

    it "generates links with code in body" do
      helper.linked_codes([model, model]).should == '<a href="/characters/1">A</a>, <a href="/characters/1">A</a>'
    end

    it "doesn't generate link for exceptional record" do
      exception = stub_model(Character)
      exception.stub(:code) { 'B' }
      
      helper.linked_codes([model, exception], exception).should == '<a href="/characters/1">A</a>, B'
    end

    it "generates html_safe string" do
      helper.linked_codes([model]).should be_html_safe
    end


  end
end
