require 'spec_helper'

describe EvaluationsController do

  before do
    @mission = Factory(:attended_mission_w_users, attendees: 2)
    @author = @mission.characters[1]
    @character = @mission.characters[0]
  end

  # This should return the minimal set of attributes required to create a valid
  # Evaluation. As you add validations to Evaluation, be sure to
  # update the return value of this method accordingly.
  let(:valid_attributes) do
    {mission_id: @mission.id, character_id: @character.id, author_id: @author.id, content: 'blah'}
  end

  describe "#index" do

    before do
      @evaluation = Evaluation.create! valid_attributes
    end
    context "for guest" do
      before { get :index }

      it { should render_template(:index) }
      it { should assign_to(:evaluations).with([@evaluation]) }
    end
  end

  describe "#show" do
    before do
      @evaluation = Evaluation.create! valid_attributes
    end

    context "for guest" do
      before { get :show, id: @evaluation.id.to_s }

      it { should render_template(:show) }
      it { should assign_to(:evaluation).with(@evaluation) }
    end
  end

  describe "#new" do

    before do
      @evaluation = Evaluation.create! valid_attributes
    end

    context "for guest" do
      before { get :new, {evaluation: valid_attributes.except(:content)} }
      it { should_not render_template(:new) }
      it { should_not assign_to(:evaluation) }
    end

    context "for user (as author)" do
      before do
        login_user @author.user
        get :new, {evaluation: valid_attributes.except(:content)}
      end

      it { should render_template(:new) }
      it { assigns(:evaluation).should be_a_new(Evaluation) }
    end

    context "for user (other)" do
      before do
        login_user
        get :new, {evaluation: valid_attributes.except(:content)}
      end

      pending do
        it { should_not render_template(:new) }
        it { should_not assign_to(:evaluation) }
      end
    end

    context "for admin" do
      before do
        login_admin
        get :new
      end

      it { should render_template(:new) }
      it { assigns(:evaluation).should be_a_new(Evaluation) }
    end

  end

  describe "#edit" do
    before do
      @evaluation = Evaluation.create! valid_attributes
    end

    context "for guest" do
      before { get :edit, id: @evaluation.id.to_s }
      it { should_not render_template(:edit) }
      it { should_not assign_to(:evaluation) }
    end

    context "for user (as author)" do
      before do
        login_user @author.user
        get :edit, id: @evaluation.id.to_s
      end

      it { should render_template(:edit) }
      it { should assign_to(:evaluation).with(@evaluation) }
    end

    context "for user (other)" do
      before do
        login_user
        get :edit, id: @evaluation.id.to_s
      end

      pending do
        it { should_not render_template(:edit) }
        it { should_not assign_to(:evaluation) }
      end
    end
  end

  describe "#create" do
    context "for guest" do
      it "fails" do
        expect {
          post :create, evaluation: valid_attributes
        }.to_not change(Evaluation, :count)
      end
    end

    context "for user (as author)" do
      before do
        login_user @author.user
      end

      describe "with valid params" do
        it "creates a new Evaluation" do
          expect {
            post :create, evaluation: valid_attributes
          }.to change(Evaluation, :count).by(1)
        end

        describe "after creating evaluation" do
          before { post :create, evaluation: valid_attributes }

          it { should assign_to(:evaluation).with_kind_of(Evaluation) }
          specify { assigns(:evaluation).should be_persisted }
          it { should redirect_to(Evaluation.last) }
        end
      end

      describe "with invalid params" do
        before do
          Evaluation.any_instance.stub(:save).and_return(false)
          post :create, :evaluation => {}
        end

        specify { assigns(:evaluation).should be_a_new(Evaluation) }
        it { should render_template("new") }
      end

    end

    context "for user (other)" do
      before do
        login_user
      end
      it "fails for injected author_id" do
        expect {
          post :create, evaluation: valid_attributes
        }.to_not change(Evaluation, :count)
      end
    end
  end

  describe "update" do
    before do
      @evaluation = Evaluation.create! valid_attributes
    end

    context "for guest" do
      it "doesn't do an update" do
        Evaluation.any_instance.should_not_receive(:update_attributes).with({'content' => 'params'})
        put :update, :id => @evaluation.id.to_s, :evaluation => {'content' => 'params'}
      end
    end

    context "for user (as author)" do
      before do
        login_user @author.user
      end

      it "updates the evaluation" do
        Evaluation.any_instance.should_receive(:update_attributes).with({'content' => 'new'})
        put :update, :id => @evaluation.id.to_s, :evaluation => {'content' => 'new'}
      end

      describe "after update" do
        before do
          put :update, id: @evaluation.id.to_s, evaluation: valid_attributes
        end

        it { should assign_to(:evaluation).with(@evaluation) }
        it { should redirect_to(@evaluation) }
      end

      describe "with invalid params" do
        before do
          Evaluation.any_instance.stub(:save).and_return(false)
          put :update, id: @evaluation.id.to_s, evaluation: {}
        end

        it { should assign_to(:evaluation).with(@evaluation) }
        it { should render_template("edit") }
      end
    end
  end
end
