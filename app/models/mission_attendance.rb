class MissionAttendance < ActiveRecord::Base

  set_primary_keys :mission_id, :character_id
  
  belongs_to :mission
  belongs_to :character
  has_many :evaluations, class_name: 'Evaluation', foreign_key: [:mission_id, :character_id]

  delegate :user, :to => :character, :prefix => true, :allow_nil => true


end
