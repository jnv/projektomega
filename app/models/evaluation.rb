class Evaluation < ActiveRecord::Base
  set_primary_keys :mission_id, :character_id, :author_id

  belongs_to :mission
  belongs_to :character
  belongs_to :author, class_name: 'Character', foreign_key: 'author_id'

  validates_presence_of :mission, :character, :author, :content

  validate :character_is_not_author, :mission_attendance_exists

  #TODO: generalize and move to standalone class as ValidateEach
  def mission_attendance_exists

    begin
      character_attendance = MissionAttendance.find([mission_id, character_id])
    rescue ActiveRecord::RecordNotFound
      errors.add(:character, :attendance_exists) if character_attendance.nil?
    end

    begin
      author_attendance = MissionAttendance.find([mission_id, author_id])
    rescue ActiveRecord::RecordNotFound
      errors.add(:author, :attendance_exists) if author_attendance.nil?
    end

  end

  def character_is_not_author
    errors.add(:author, :character_is_not_author) if character_id == author_id
  end
  
end
