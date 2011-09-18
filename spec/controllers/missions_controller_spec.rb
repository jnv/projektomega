require 'spec_helper'

describe MissionsController do

  def valid_attributes
    {number: '76', name: 'Overlord'}
  end

  describe "GET index" do
    it "assigns all missions as @missions" do
      mission = Mission.create! valid_attributes
      get :index
      assigns(:missions).should eq([mission])
    end
  end

  describe "GET show" do
    it "assigns the requested mission as @mission" do
      mission = Mission.create! valid_attributes
      get :show, :id => mission.id.to_s
      assigns(:mission).should eq(mission)
    end
  end

  describe "GET new" do
    it "assigns a new mission as @mission" do
      get :new
      assigns(:mission).should be_a_new(Mission)
    end
  end

  describe "GET edit" do
    it "assigns the requested mission as @mission" do
      mission = Mission.create! valid_attributes
      get :edit, :id => mission.id.to_s
      assigns(:mission).should eq(mission)
    end
  end

  describe "POST create" do
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

    describe "with invalid params" do
      it "assigns a newly created but unsaved mission as @mission" do
        # Trigger the behavior that occurs when invalid params are submitted
        Mission.any_instance.stub(:save).and_return(false)
        post :create, :mission => {}
        assigns(:mission).should be_a_new(Mission)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Mission.any_instance.stub(:save).and_return(false)
        post :create, :mission => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested mission" do
        mission = Mission.create! valid_attributes
        # Assuming there are no other missions in the database, this
        # specifies that the Mission created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Mission.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => mission.id, :mission => {'these' => 'params'}
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

  describe "DELETE destroy" do
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

end
