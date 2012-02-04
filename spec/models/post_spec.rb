require 'spec_helper'

describe Post do

  describe "associations" do
    it { should belong_to(:character) }
    it { should belong_to(:user) }
  end

  describe "validations" do

      it { should validate_presence_of(:user) }
      it { should validate_presence_of(:content) }

    end

end
