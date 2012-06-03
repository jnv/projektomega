require 'spec_helper'

describe Ability do

  let(:ability) { Ability.new(user) }

  subject { ability }

  let(:user) { FactoryGirl.create(:user) }
  let(:character) { FactoryGirl.build(:character) }
  let(:mission) { FactoryGirl.build(:mission) }
  let(:report) { FactoryGirl.build(:report) }
  let(:evaluation) { FactoryGirl.build(:evaluation) }
  let(:post) { FactoryGirl.build(:post) }

  context "guest" do
    let(:user) { nil }

    it { should be_able_to(:read, character) }
    it { should_not be_able_to(:update, character) }
    it { should_not be_able_to(:create, Character.new) }
    it { should be_able_to :read, mission }
    it { should_not be_able_to(:update, mission) }
    it { should_not be_able_to(:create, Mission.new) }
    it { should_not be_able_to(:update, report) }

    it { should be_able_to(:read, evaluation) }
    it { should_not be_able_to(:create, Evaluation.new) }
    it { should_not be_able_to(:update, evaluation) }

    it { should_not be_able_to(:create, Post.new) }
    it { should_not be_able_to(:create, post) }
  end


  context "user" do

    context "without any character" do
      let(:character) { FactoryGirl.create(:orphaned_character) }

      it { should_not be_able_to(:create, Post.new(character: character)) }
    end


    context "his own character" do
      let(:character) { FactoryGirl.create(:character, { user: user }) }
      let(:report) { FactoryGirl.build(:report, {character: character}) }
      let(:evaluation) { FactoryGirl.build(:evaluation, {author: character}) }
      let(:post) { FactoryGirl.build(:post, {character: character}) }

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
        it { should_not be_able_to(:destroy, post) }
      end
    end

    context "any other character" do
      it { should be_able_to(:read, character) }
      it { should_not be_able_to(:update, character) }
      describe "report" do
        it { should_not be_able_to(:update, report) }
      end

      describe "evaluation" do
        let(:evaluation) { FactoryGirl.build(:evaluation) }
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
      it { should_not be_able_to :create, Mission.new }
    end


    #specify { should be_able_to :update, FactoryGirl.create(:character, {user: user}), "User #{user.id} cant update character owned by user #{character.user_id}" }

    #it { should_not be_able_to :edit, FactoryGirl.build(:character) }

  end

  describe "for role :admin" do

    let(:user) { FactoryGirl.build(:admin) }

    it { should be_able_to(:read, character) }
    it { should be_able_to(:update, character) }
    it { should be_able_to(:create, Character.new) }
    it { should be_able_to(:destroy, character) }
    it { should be_able_to(:read, mission) }
    it { should be_able_to(:update, mission) }
    it { should be_able_to(:create, Mission.new) }
    it { should be_able_to(:destroy, mission) }
    it { should be_able_to(:update, report) }

    it { should be_able_to(:read, evaluation) }
    it { should be_able_to(:create, Evaluation.new) }
    it { should be_able_to(:update, evaluation) }


  end

end