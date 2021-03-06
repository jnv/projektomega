class Mission < ActiveRecord::Base

  has_many :characters, through: :attendances, order: 'number ASC'
  has_many :attendances, class_name: 'MissionAttendance', dependent: :destroy
  has_many :evaluations, dependent: :destroy

  validates_presence_of :number, :name
  validates :number, uniqueness: true, numericality: {only_integer: true, greater_than: 0}

  default_scope order: 'number ASC'

  delegate :with_evaluations, to: :attendances, prefix: true, allow_nil: true
  delegate :with_characters, to: :attendances, prefix: true, allow_nil: true

  def code
    "M#{number}"
  end
  alias_method :abbr, :code

  def full_name
    "#{abbr} #{name}"
  end

  def to_s
    full_name
  end

end

# == Schema Information
#
# Table name: missions
#
#  id          :integer          not null, primary key
#  number      :integer          not null
#  name        :string(255)      not null
#  date        :string(255)
#  location    :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

