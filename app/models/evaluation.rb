class Evaluation < ActiveRecord::Base
  self.primary_keys = :mission_id, :character_id, :author_id

  belongs_to :mission, inverse_of: :evaluations
  belongs_to :character, inverse_of: :evaluations
  belongs_to :author, class_name: 'Character', foreign_key: 'author_id', inverse_of: :authored_evaluations
  belongs_to :attendance, class_name: 'MissionAttendance', foreign_key: [:mission_id, :character_id]

  attr_readonly :mission, :character, :author

  validates_presence_of :mission, :character, :author, :content

  validate :character_is_not_author, :mission_attendance_exists

  #default_scope :order => 'author_id ASC, mission_id ASC, character_id ASC'
  scope :with_all, includes(:mission, :character, :author).order('missions.number, characters.number')


  def self.group_by_mission
    with_all.group_by(&:mission)
  end

  def self.group_by_character
    with_all.group_by(&:character)
  end

  def self.group_by_author
    with_all.group_by(&:author)
  end

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
