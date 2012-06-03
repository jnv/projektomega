require 'spec_helper'

describe MissionsController do
  let(:valid_attributes) { FactoryGirl.attributes_for(:mission) }
  let!(:mission) { FactoryGirl.create(:mission) }

  shared_examples "CRUD GET index" do
    it "should render index" do
      get :index
      response.should render_template(:index)
    end

    it "assigns all missions as @missions" do
      get :index
      assigns(:missions).should eq([mission])
    end
  end

  shared_examples "CRUD GET show" do
    it "assigns the requested mission as @mission" do
      get :show, :id => mission.id.to_s
      assigns(:mission).should eq(mission)
    end
  end

  shared_examples "CRUD GET new" do
    it "assigns a new mission as @mission" do
      get :new
      assigns(:mission).should be_a_new(Mission)
    end
  end
  shared_examples "CRUD POST create" do
    describe "with valid params" do
      it "creates a new Mission" do
        expect {
          post :create, :mission => valid_attributes
        }.to change(Mission, :count).by(1)
      end

      it "assigns a newly created mission as @mission" do
        post :create, :mission => valid_attributes
        assigns(:mission).should be_a(Mission)
        assigns(:mission).should be_persisted
      end

      it "redirects to the created mission" do
        post :create, :mission => valid_attributes
        response.should redirect_to(Mission.last)
      end
    end
  end
  shared_examples "CRUD GET edit" do
    it "assigns the requested mission as @mission" do
      get :edit, :id => mission.id.to_s
      assigns(:mission).should eq(mission)
    end
  end

  shared_examples "CRUD PUT update" do
    describe "with valid params" do
      it "updates the requested mission" do
        # Assuming there are no other missions in the database, this
        # specifies that the Mission created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Mission.any_instance.should_receive(:update_attributes).with({'name' => 'params'})
        put :update, :id => mission.id, :mission => {'name' => 'params'}
      end

      it "assigns the requested mission as @mission" do
        mission = Mission.create! valid_attributes
        put :update, :id => mission.id, :mission => valid_attributes
        assigns(:mission).should eq(mission)
      end

      it "redirects to the mission" do
        mission = Mission.create! valid_attributes
        put :update, :id => mission.id, :mission => valid_attributes
        response.should redirect_to(mission)
      end
    end

    describe "with invalid params" do
      it "assigns the mission as @mission" do
        mission = Mission.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Mission.any_instance.stub(:save).and_return(false)
        put :update, :id => mission.id.to_s, :mission => {}
        assigns(:mission).should eq(mission)
      end

      it "re-renders the 'edit' template" do
        mission = Mission.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Mission.any_instance.stub(:save).and_return(false)
        put :update, :id => mission.id.to_s, :mission => {}
        response.should render_template("edit")
      end
    end
  end


  shared_examples "CRUD DELETE destroy" do
    it "destroys the requested mission" do
      mission = Mission.create! valid_attributes
      expect {
        delete :destroy, :id => mission.id.to_s
      }.to change(Mission, :count).by(-1)
    end

    it "redirects to the missions list" do
      mission = Mission.create! valid_attributes
      delete :destroy, :id => mission.id.to_s
      response.should redirect_to(missions_url)
    end
  end

  ### Tests

  context "guest user" do
    it_should_behave_like "CRUD GET index"
    it_should_behave_like "CRUD GET show"

    it_behaves_like "authorized controller", {
        :new => :get,
        :create => :post,
        :edit => :get,
        :update => :post,
    }
  end

  context "administrator" do
    before :each do
      login_admin
    end

    it_should_behave_like "CRUD GET index"
    it_should_behave_like "CRUD GET show"
    it_should_behave_like "CRUD GET new"
    it_should_behave_like "CRUD GET edit"
    it_should_behave_like "CRUD POST create"
    it_should_behave_like "CRUD PUT update"
  end

end


