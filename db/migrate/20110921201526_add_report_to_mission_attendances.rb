class AddReportToMissionAttendances < ActiveRecord::Migration
  def change
    add_column :mission_attendances, :report, :text
  end
end
