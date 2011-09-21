class MissionAttendance < ActiveRecord::Base

  set_primary_keys :mission_id, :character_id
  
  belongs_to :mission
  belongs_to :character

  
end