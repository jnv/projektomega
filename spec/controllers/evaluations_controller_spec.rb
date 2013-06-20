require 'spec_helper'

describe EvaluationsController do
  let(:mission) { FactoryGirl.create(:attended_mission_w_users, attendees: 2) }
  let(:author) { mission.characters[1] }
  let(:character) { mission.characters[0] }

  let(:evaluation) { Evaluation.create! valid_attributes }

  let(:valid_attributes) do
    { mission_id: mission.id, character_id: character.id, author_id: author.id, content: 'blah' }
  end

  describe "GET #index" do
    context "for guest" do
      before { get :index }

      it { should render_template(:index) }
      specify { assigns(:evaluations).should eq([evaluation]) }
    end
  end

  describe "GET #show" do
    context "for guest" do
      before { get :show, id: evaluation.id.to_s }

      it { should render_template(:show) }
      specify { assigns(:evaluation).should eq(evaluation) }
    end
  end

  describe "GET #new" do
    context "for guest" do
      before { get :new, {evaluation: valid_attributes.except(:content)} }

      it { should_not render_template(:new) }
      specify { assigns(:evaluation).should be_blank }
    end

    context "for user (as author)" do
      before do
        login_user author.user
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

  describe "GET #edit" do
    context "for guest" do
      before { get :edit, id: evaluation.id.to_s }

      it { should_not render_template(:edit) }
      specify { assigns(:evaluation).should be_blank }
    end

    context "for user (as author)" do
      before do
        login_user author.user
        get :edit, id: evaluation.id.to_s
      end

      it { should render_template(:edit) }
      specify { assigns(:evaluation).should eql(evaluation) }
    end

    context "for user (other)" do
      before do
        login_user character.user
        get :edit, id: evaluation.id.to_s
      end

      it { should_not render_template(:edit) }
    end
  end

  describe "POST #create" do
    context "for guest" do
      it "fails" do
        expect {
          post :create, evaluation: valid_attributes
        }.to_not change(Evaluation, :count)
      end
    end

    context "for user (as author)" do
      before do
        login_user author.user
      end

      describe "with valid params" do
        it "creates a new Evaluation" do
          expect {
            post :create, evaluation: valid_attributes.except(:author_id)
          }.to change(Evaluation, :count).by(1)
        end

        describe "after creating evaluation" do
          before { post :create, evaluation: valid_attributes.except(:author_id) }

          specify { assigns(:evaluation).should be_persisted }
          it { should redirect_to(Evaluation.last) }
        end
      end

      describe "with invalid params" do
        before do
          #Evaluation.any_instance.stub(:save).and_return(false)
          post :create, :evaluation => {content: ''}
        end

        specify { assigns(:evaluation).should be_a_new(Evaluation) }
        it { should render_template(:new) }
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

  describe "PUT #update" do
    context "for guest" do
      it "doesn't do an update" do
        Evaluation.any_instance.should_not_receive(:update_attributes).with({'content' => 'params'})
        put :update, :id => evaluation.id.to_s, :evaluation => {'content' => 'params'}
      end
    end

    context "for user (as author)" do
      before do
        login_user author.user
      end

      it "updates the evaluation" do
        Evaluation.any_instance.should_receive(:update_attributes).with({'content' => 'new'})
        put :update, :id => evaluation.id.to_s, :evaluation => {'content' => 'new'}
      end

      describe "after update" do
        before do
          put :update, id: evaluation.id.to_s, evaluation: valid_attributes
        end

        specify { assigns(:evaluation).should eql(evaluation) }
        it { should redirect_to(evaluation) }
      end

      describe "with invalid params" do
        before do
          # Evaluation.any_instance.stub(:save).and_return(false)
          put :update, id: evaluation.id.to_s, evaluation: {content: ""}
        end

        specify { assigns(:evaluation).should eql(evaluation) }
        it { should render_template("edit") }
      end
    end
  end
end
