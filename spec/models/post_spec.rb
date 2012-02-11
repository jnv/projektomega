require 'spec_helper'

describe Post do

  describe "associations" do
    it { should belong_to(:character) }
  end

  describe "validations" do

      it { should validate_presence_of(:content) }

    end

end
