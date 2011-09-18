require 'spec_helper'

describe Ability do

  let(:ability) do
    Ability.new(user)
  end

  subject { ability }

  describe "for guest" do
    let(:user) { nil }
    let(:character) do
      Factory.build(:character)
    end

    it { should be_able_to(:read, character) }
    it { should_not be_able_to(:update, character) }

  end


  describe "for role :user" do

    let(:user) do
      Factory(:user)
    end

    describe "and its own character" do
      let(:character) do
        Factory.build(:character, {user: user})
      end

      it { should be_able_to(:read, character) }
      it { should be_able_to(:update, character) }
      it { should_not be_able_to(:update, character, :user)}
      it { should_not be_able_to(:update, character, :user_id)}
      it { should_not be_able_to(:update, character, :number)}
    end

    describe "and any other character" do
      let(:character) do
        Factory.build(:character)
      end

      it { should be_able_to(:read, character) }
      it { should_not be_able_to(:update, character) }
    end

    #specify { should be_able_to :update, Factory.create(:character, {user: user}), "User #{user.id} cant update character owned by user #{character.user_id}" }

    #it { should_not be_able_to :edit, Factory.build(:character) }

  end

  describe "for role :admin" do

    let(:user) do
      Factory.build(:admin)
    end

    let(:character) do
      Factory.build(:character)
    end

    it { should be_able_to(:read, character) }
    it { should be_able_to(:update, character) }
    it { should be_able_to(:create, Character) }
    it { should be_able_to(:destroy, character) }


  end

end