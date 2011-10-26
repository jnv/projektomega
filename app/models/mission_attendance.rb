class MissionAttendance < ActiveRecord::Base

  set_primary_keys :mission_id, :character_id
  
  belongs_to :mission
  belongs_to :character
  has_many :evaluations, foreign_key: [:mission_id, :character_id]

  scope :with_evaluations, includes(:evaluations)
  #scope :evaluations_nil, evaluations_all.where(evaluations: {content: nil})

  delegate :user, :to => :character, :prefix => true, :allow_nil => true

  def self.evaluations

  end

end
