require 'spec_helper'

describe EvaluationsController do

  # This should return the minimal set of attributes required to create a valid
  # Evaluation. As you add validations to Evaluation, be sure to
  # update the return value of this method accordingly.
  let(:valid_attributes) do
    mission = Factory(:attended_mission, attendees: 2)
    {mission_id: mission.id, character_id: mission.characters[0].id, author_id: mission.characters[1].id, content: 'blah' }
  end

  describe "#index" do

    before do
      @evaluation = Evaluation.create! valid_attributes
    end
    context "for anonymous user" do
      before { get :index }

      it { should render_template(:index) }
      it { should assign_to(:evaluations).with([@evaluation]) }
    end

  end

  describe "#show" do
    before do
      @evaluation = Evaluation.create! valid_attributes
    end

    context "for anonymous user" do
      before { get :show, id: @evaluation.id.to_s }

      it { should render_template(:show) }
      it { should assign_to(:evaluation).with(@evaluation) }
    end
  end

  #
  #describe "GET new" do
  #  it "assigns a new evaluation as @evaluation" do
  #    get :new
  #    assigns(:evaluation).should be_a_new(Evaluation)
  #  end
  #end
  #
  #describe "GET edit" do
  #  it "assigns the requested evaluation as @evaluation" do
  #    evaluation = Evaluation.create! valid_attributes
  #    get :edit, :id => evaluation.id
  #    assigns(:evaluation).should eq(evaluation)
  #  end
  #end
  #
  #describe "POST create" do
  #  describe "with valid params" do
  #    it "creates a new Evaluation" do
  #      expect {
  #        post :create, :evaluation => valid_attributes
  #      }.to change(Evaluation, :count).by(1)
  #    end
  #
  #    it "assigns a newly created evaluation as @evaluation" do
  #      post :create, :evaluation => valid_attributes
  #      assigns(:evaluation).should be_a(Evaluation)
  #      assigns(:evaluation).should be_persisted
  #    end
  #
  #    it "redirects to the created evaluation" do
  #      post :create, :evaluation => valid_attributes
  #      response.should redirect_to(Evaluation.last)
  #    end
  #  end
  #
  #  describe "with invalid params" do
  #    it "assigns a newly created but unsaved evaluation as @evaluation" do
  #      # Trigger the behavior that occurs when invalid params are submitted
  #      Evaluation.any_instance.stub(:save).and_return(false)
  #      post :create, :evaluation => {}
  #      assigns(:evaluation).should be_a_new(Evaluation)
  #    end
  #
  #    it "re-renders the 'new' template" do
  #      # Trigger the behavior that occurs when invalid params are submitted
  #      Evaluation.any_instance.stub(:save).and_return(false)
  #      post :create, :evaluation => {}
  #      response.should render_template("new")
  #    end
  #  end
  #end
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
