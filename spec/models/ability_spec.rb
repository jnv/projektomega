require 'spec_helper'

describe Ability do

  let(:ability) { Ability.new(user) }

  subject { ability }

  let(:user) { Factory(:user) }
  let(:character) { Factory.build(:character) }
  let(:mission) { Factory.build(:mission) }
  let(:report) { Factory.build(:report) }

  context "guest" do
    let(:user) { nil }

    it { should be_able_to(:read, character) }
    it { should_not be_able_to(:update, character) }
    it { should_not be_able_to(:create, character) }
    it { should be_able_to :read, mission }
    it { should_not be_able_to(:update, mission) }
    it { should_not be_able_to(:create, Mission) }
    it { should_not be_able_to(:update, report) }

  end


  context "user" do

    context "his own character" do
      let(:character) { Factory.build(:character, {user: user}) }
      let(:report) { Factory.build(:report, {character: character}) }

      it { should be_able_to(:read, character) }
      it { should be_able_to(:update, character) }
      it { should_not be_able_to(:update, character, :user) }
      it { should_not be_able_to(:update, character, :user_id) }
      context "character's report" do
        it { should be_able_to(:update, report) }
      end
      #it { should_not be_able_to(:update, character, :number)}
    end

    context "any other character" do
      it { should be_able_to(:read, character) }
      it { should_not be_able_to(:update, character) }
      context "report" do
        it { should_not be_able_to(:update, report) }
      end
    end

    describe "mission" do
      it { should be_able_to(:read, mission) }
      it { should_not be_able_to :update, mission }
      it { should_not be_able_to :create, Mission }
    end


    #specify { should be_able_to :update, Factory.create(:character, {user: user}), "User #{user.id} cant update character owned by user #{character.user_id}" }

    #it { should_not be_able_to :edit, Factory.build(:character) }

  end

  describe "for role :admin" do

    let(:user) { Factory.build(:admin) }

    it { should be_able_to(:read, character) }
    it { should be_able_to(:update, character) }
    it { should be_able_to(:create, Character) }
    it { should be_able_to(:destroy, character) }
    it { should be_able_to(:read, mission) }
    it { should be_able_to(:update, mission) }
    it { should be_able_to(:create, Mission) }
    it { should be_able_to(:destroy, mission) }
    it { should be_able_to(:update, report) }

  end

end