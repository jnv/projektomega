# encoding: utf-8
require 'spec_helper'

describe "characters/new.html.haml" do
  before(:each) do
    assign(:character, stub_model(Character,
                                  :number => "5",
                                  :name => "MyString",
                                  :born => "MyString",
                                  :country => "MyString",
                                  :assignment => "MyString",
                                  :specialisation => "MyString"
    ).as_new_record)
  end

  let(:rendered) { Capybara::Node::Simple.new(@rendered) }
  

  it "renders new character form" do
    render

    rendered.find("form[method='post'][action='#{characters_path}']").tap do |form|
      #form.should have_required_field("Číslo agenta")
      form.should have_required_field("Jméno")
      form.should have_not_required_field("Rok narození")
      form.should have_not_required_field("Specializace")
      form.should have_not_required_field("Stát")
      form.should have_not_required_field("Pověření")
      form.should_not have_field("character[user]")
    end

  end
end
