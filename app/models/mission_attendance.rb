class MissionAttendance < ActiveRecord::Base
  belongs_to :mission
  belongs_to :character
end
