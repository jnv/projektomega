class Mission < ActiveRecord::Base

  has_many :attendances, class_name: 'MissionAttendance'
  has_many :characters, through: :attendances

  validates_presence_of :number, :name
  validates :number, uniqueness: true, numericality: {only_integer: true, greater_than: 0}

  def code
    "M#{number}"
  end
  alias_method :abbr, :code

  def full_name
    "#{abbr} #{name}"
  end

  def to_s
    name
  end

end
