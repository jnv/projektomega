require 'spec_helper'

describe "characters/new.html.erb" do
  before(:each) do
    assign(:character, stub_model(Character,
      :name => "MyString",
      :born => "MyString",
      :country => "MyString",
      :assignment => "MyString",
      :specialisation => "MyString"
    ).as_new_record)
  end

  it "renders new character form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => characters_path, :method => "post" do
      assert_select "input#character_name", :name => "character[name]"
      assert_select "input#character_born", :name => "character[born]"
      assert_select "input#character_country", :name => "character[country]"
      assert_select "input#character_assignment", :name => "character[assignment]"
      assert_select "input#character_specialisation", :name => "character[specialisation]"
    end
  end
end
