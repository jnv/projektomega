require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the NamesHelper. For example:
#
# describe NamesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe NamesHelper do

  describe "linked_name" do

    let(:model) do
      model = stub_model(Character)
      model.stub(:id) { 1 }
      model.stub(:full_name) { 'My Name' }
      model.stub(:number) { 1 }
      model
    end

    it "generates link with full name in body" do
      helper.linked_name(model).should == '<a href="/characters/1" data-number="1">My Name</a>'
    end

    it "handles non-existent model with bravery and honour" do
      helper.linked_name.should be_blank
    end
  end

end
