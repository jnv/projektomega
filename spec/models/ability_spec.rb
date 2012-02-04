require 'spec_helper'

describe Ability do

  let(:ability) { Ability.new(user) }

  subject { ability }

  let(:user) { Factory(:user) }
  let(:character) { Factory.build(:character) }
  let(:mission) { Factory.build(:mission) }
  let(:report) { Factory.build(:report) }
  let(:evaluation) { Factory.build(:evaluation) }
  let(:post) { Factory.build(:post) }

  context "guest" do
    let(:user) { nil }

    it { should be_able_to(:read, character) }
    it { should_not be_able_to(:update, character) }
    it { should_not be_able_to(:create, Character) }
    it { should be_able_to :read, mission }
    it { should_not be_able_to(:update, mission) }
    it { should_not be_able_to(:create, Mission) }
    it { should_not be_able_to(:update, report) }

    it { should be_able_to(:read, evaluation) }
    it { should_not be_able_to(:create, Evaluation) }
    it { should_not be_able_to(:update, evaluation) }

    it { should_not be_able_to(:create, Post) }
    it { should_not be_able_to(:create, post) }
  end


  context "user" do

    context "without any character" do
      it { should_not be_able_to(:create, post) }
    end


    context "his own character" do
      let(:character) { Factory.build(:character, {user: user}) }
      let(:report) { Factory.build(:report, {character: character}) }
      let(:evaluation) { Factory.build(:evaluation, {author: character}) }
      let(:post) { Factory.build(:post, {character: character, user: user}) }

      it { should be_able_to(:read, character) }
      it { should be_able_to(:update, character) }
      it { should_not be_able_to(:update, character, :user) }
      it { should_not be_able_to(:update, character, :user_id) }
      describe "character's report" do
        it { should be_able_to(:update, report) }
      end
      describe "authored evaluation" do
        it { should be_able_to(:create, evaluation) }
        it { should be_able_to(:update, evaluation) }
      end
      #it { should_not be_able_to(:update, character, :number)}

      describe "post" do
        it { should be_able_to(:create, post) }
        it { should be_able_to(:edit, post) }
      end
    end

    context "any other character" do
      it { should be_able_to(:read, character) }
      it { should_not be_able_to(:update, character) }
      describe "report" do
        it { should_not be_able_to(:update, report) }
      end

      describe "evaluation" do
        let(:evaluation) { Factory.build(:evaluation) }
        it { should_not be_able_to(:create, evaluation) }
        it { should_not be_able_to(:update, evaluation) }
      end

      describe "post" do
        it { should_not be_able_to(:edit, post) }
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

    it { should be_able_to(:read, evaluation) }
    it { should be_able_to(:create, Evaluation) }
    it { should be_able_to(:update, evaluation) }


  end

end