require 'spec_helper'

describe MissionAttendancesController do

  let(:user) { FactoryGirl.create(:user) }
  let(:character) { FactoryGirl.create(:character, user: user) }
  let(:report) { FactoryGirl.create(:report, character: character) }

  def valid_attributes
    {report: "My Report Text"}
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

    it "should fail for guest" do
      get :edit, :id => report.id.to_s
      response.should_not render_template(:edit)
    end

    context "user" do
      before do
        login_user user
      end
      it "assigns the requested mission_attendance as @mission_attendance" do
        get :edit, :id => report.id.to_s
        assigns(:mission_attendance).should eq(report)
      end
    end

  end

  describe "PUT update" do

    context "user" do
      before do
        login_user user
      end

      describe "with valid params" do
        it "updates the requested mission_attendance" do
          MissionAttendance.any_instance.should_receive(:update_attributes).with({'report' => 'blah'})
          put :update, :id => report.id.to_s, :mission_attendance => {'report' => 'blah'}
        end

        it "assigns the requested mission_attendance as @mission_attendance" do
          put :update, :id => report.id.to_s, :mission_attendance => valid_attributes
          assigns(:mission_attendance).should eq(report)
        end

        it "redirects to the mission_attendance" do
          put :update, :id => report.to_param, :mission_attendance => valid_attributes
          response.should redirect_to(report)
        end
      end

      describe "with invalid params" do
        before do
          report
        end
        it "assigns the mission_attendance as @mission_attendance" do
          MissionAttendance.any_instance.stub(:save).and_return(false)
          put :update, :id => report.id.to_s, :mission_attendance => {'report'=>'blah'}
          assigns(:mission_attendance).should eq(report)
        end

        it "re-renders the 'edit' template" do
          MissionAttendance.any_instance.stub(:save).and_return(false)
          MissionAttendance.any_instance.stub(:errors).and_return(['error'])
          put :update, :id => report.id.to_s, :mission_attendance => {'report'=>'blah'}
          response.should render_template(:edit)
        end
      end
    end
  end

  describe "PUT empty" do
    context "admin" do
      before do
        login_admin
      end

      it "empties report" do
        report.should be_filled
        put :empty, id: report.id.to_s
        report.reload.should_not be_filled
      end
    end
  end
end
