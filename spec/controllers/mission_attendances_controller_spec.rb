require 'spec_helper'

describe MissionAttendancesController do

  def valid_attributes
    {report: "My Report Text"}
  end

  def prepare_user
    @user = login_user
    @character = FactoryGirl.create(:character, user: @user)
    @mission_attendance = FactoryGirl.create(:report, character: @character)
  end

  describe "GET index" do
    it "assigns all mission_attendances as @mission_attendances" do
      mission_attendance = FactoryGirl.create(:report)
      get :index
      assigns(:mission_attendances).should eq([mission_attendance])
    end
  end

  describe "GET show" do
    it "assigns the requested mission_attendance as @mission_attendance" do
      mission_attendance = FactoryGirl.create(:report)
      get :show, :id => mission_attendance.id.to_s
      assigns(:mission_attendance).should eq(mission_attendance)
    end
  end

  describe "GET edit" do
    before :each do
      @mission_attendance = FactoryGirl.create(:report)
    end

    it "should fail for guest" do
      get :edit, :id => @mission_attendance.id.to_s
      response.should_not render_template(:edit)
    end

    context ":user" do
      it "assigns the requested mission_attendance as @mission_attendance" do
        prepare_user
        get :edit, :id => @mission_attendance.id.to_s
        assigns(:mission_attendance).should eq(@mission_attendance)
      end
    end

  end

  describe "PUT update" do

    context ":user" do
      before :each do
        prepare_user
      end

      describe "with valid params" do
        it "updates the requested mission_attendance" do
          MissionAttendance.any_instance.should_receive(:update_attributes).with({'report' => 'blah'})
          put :update, :id => @mission_attendance.id.to_s, :mission_attendance => {'report' => 'blah'}
        end

        it "assigns the requested mission_attendance as @mission_attendance" do
          put :update, :id => @mission_attendance.id.to_s, :mission_attendance => valid_attributes
          assigns(:mission_attendance).should eq(@mission_attendance)
        end

        it "redirects to the mission_attendance" do
          put :update, :id => @mission_attendance.to_param, :mission_attendance => valid_attributes
          response.should redirect_to(@mission_attendance)
        end
      end

      describe "with invalid params" do
        it "assigns the mission_attendance as @mission_attendance" do
          MissionAttendance.any_instance.stub(:save).and_return(false)
          put :update, :id => @mission_attendance.id.to_s, :mission_attendance => {'report'=>'blah'}
          assigns(:mission_attendance).should eq(@mission_attendance)
        end

        it "re-renders the 'edit' template" do
          MissionAttendance.any_instance.stub(:save).and_return(false)
          put :update, :id => @mission_attendance.id.to_s, :mission_attendance => {'report'=>'blah'}
          response.should render_template("edit")
        end
      end

    end
  end


end
