class Character < ActiveRecord::Base

  belongs_to :user
  has_many :attendances, class_name: 'MissionAttendance'
  has_many :missions, through: :attendances
  has_many :evaluations
  has_many :authored_evaluations, class_name: 'Evaluation', foreign_key: 'author_id'

  attr_readonly :number
  validates_presence_of :number, :name
  validates :number, uniqueness: true, numericality: {only_integer: true, greater_than: 0}

  def code
    "A#{number}"
  end
  alias_method :abbr, :code

  def full_name
    "#{abbr} #{name}"
  end

  def to_s
    name
  end

end
