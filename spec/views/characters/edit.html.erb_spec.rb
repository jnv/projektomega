require 'spec_helper'

describe "characters/edit.html.erb" do
  before(:each) do
    @character = assign(:character, stub_model(Character,
      :name => "MyString",
      :born => "MyString",
      :country => "MyString",
      :assignment => "MyString",
      :specialisation => "MyString"
    ))
  end

  it "renders the edit character form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => characters_path(@character), :method => "post" do
      assert_select "input#character_name", :name => "character[name]"
      assert_select "input#character_born", :name => "character[born]"
      assert_select "input#character_country", :name => "character[country]"
      assert_select "input#character_assignment", :name => "character[assignment]"
      assert_select "input#character_specialisation", :name => "character[specialisation]"
    end
  end
end
