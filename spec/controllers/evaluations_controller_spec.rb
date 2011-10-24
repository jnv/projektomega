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

      pending do
        describe "with invalid params" do
          before do
            Evaluation.any_instance.stub(:save).and_return(false)
            post :create, :evaluation => {}
          end

          specify { assigns(:evaluation).should be_a_new(Evaluation) }
          it { should render_template("new") }
        end
      end

    end

    context "for user (other)" do
      before do
        login_user
      end
      it "fails" do
        expect {
          post :create, evaluation: valid_attributes
        }.to_not change(Evaluation, :count)
      end
    end
  end
  #
  #describe "PUT update" do
  #  describe "with valid params" do
  #    it "updates the requested evaluation" do
  #      evaluation = Evaluation.create! valid_attributes
  #      # Assuming there are no other evaluations in the database, this
  #      # specifies that the Evaluation created on the previous line
  #      # receives the :update_attributes message with whatever params are
  #      # submitted in the request.
  #      Evaluation.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
  #      put :update, :id => evaluation.id, :evaluation => {'these' => 'params'}
  #    end
  #
  #    it "assigns the requested evaluation as @evaluation" do
  #      evaluation = Evaluation.create! valid_attributes
  #      put :update, :id => evaluation.id, :evaluation => valid_attributes
  #      assigns(:evaluation).should eq(evaluation)
  #    end
  #
  #    it "redirects to the evaluation" do
  #      evaluation = Evaluation.create! valid_attributes
  #      put :update, :id => evaluation.id, :evaluation => valid_attributes
  #      response.should redirect_to(evaluation)
  #    end
  #  end
  #
  #  describe "with invalid params" do
  #    it "assigns the evaluation as @evaluation" do
  #      evaluation = Evaluation.create! valid_attributes
  #      # Trigger the behavior that occurs when invalid params are submitted
  #      Evaluation.any_instance.stub(:save).and_return(false)
  #      put :update, :id => evaluation.id, :evaluation => {}
  #      assigns(:evaluation).should eq(evaluation)
  #    end
  #
  #    it "re-renders the 'edit' template" do
  #      evaluation = Evaluation.create! valid_attributes
  #      # Trigger the behavior that occurs when invalid params are submitted
  #      Evaluation.any_instance.stub(:save).and_return(false)
  #      put :update, :id => evaluation.id, :evaluation => {}
  #      response.should render_template("edit")
  #    end
  #  end
  #end
  #
  #describe "DELETE destroy" do
  #  it "destroys the requested evaluation" do
  #    evaluation = Evaluation.create! valid_attributes
  #    expect {
  #      delete :destroy, :id => evaluation.id
  #    }.to change(Evaluation, :count).by(-1)
  #  end
  #
  #  it "redirects to the evaluations list" do
  #    evaluation = Evaluation.create! valid_attributes
  #    delete :destroy, :id => evaluation.id
  #    response.should redirect_to(evaluations_url)
  #  end
  #end

end
