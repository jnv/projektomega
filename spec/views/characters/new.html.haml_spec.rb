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

  before :each do
    stub_ability
  end

  it "renders new character form" do
    #@ability.can :update, Character, :user
    render

    rendered.find("form[method='post'][action='#{characters_path}']").tap do |form|
      form.should have_required_field("Číslo agenta")
      form.should have_not_readonly_field("Číslo agenta")
      form.should have_required_field("Jméno")
      form.should have_not_required_field("Rok narození")
      form.should have_not_required_field("Specializace")
      form.should have_not_required_field("Stát")
      form.should have_not_required_field("Pověření")
      form.should have_no_field("character[user]")
    end

  end

  it "renders new character form with User field for authorized user" do
    @ability.can :access, :all
    render

    rendered.find("form[method='post'][action='#{characters_path}']").tap do |form|
      form.should have_field("Hráč")
    end

  end
end
