# encoding: utf-8
require 'spec_helper'

describe "characters/edit.html.haml" do
  before(:each) do
    @character = assign(:character, stub_model(Character,
                                  :number => "5",
                                  :name => "MyString",
                                  :born => "MyString",
                                  :country => "MyString",
                                  :assignment => "MyString",
                                  :specialisation => "MyString"
    ))
  end

  before :each do
    stub_ability
  end

  it "renders the edit character form" do
    #@ability.can :update, Character, :user
    render

    rendered.find("form[method='post'][action='#{character_path(@character)}']").tap do |form|
      form.should have_readonly_field("Číslo agenta")
      form.should have_no_field("character[user]")
    end

  end
end
