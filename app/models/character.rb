class Character < ActiveRecord::Base

  belongs_to :user
  has_many :missions, through: :attendances#, order: 'missions.number ASC'
  has_many :attendances, class_name: 'MissionAttendance', dependent: :destroy
  has_many :evaluations, inverse_of: :character, dependent: :destroy
  has_many :authored_evaluations, class_name: 'Evaluation', foreign_key: 'author_id', inverse_of: :author, dependent: :destroy

  attr_readonly :number
  validates_presence_of :number, :name
  validates :number, uniqueness: true, numericality: {only_integer: true, greater_than: 0}

  default_scope :order => 'number ASC'

  delegate :with_evaluations, to: :attendances, prefix: true, allow_nil: true
  delegate :with_missions, to: :attendances, prefix: true, allow_nil: true

  mount_uploader :portrait, PortraitUploader

  def code
    "A#{number}"
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
# Table name: characters
#
#  id             :integer          not null, primary key
#  number         :integer          not null
#  name           :string(255)      not null
#  born           :string(255)
#  country        :string(255)
#  assignment     :string(255)
#  specialisation :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  portrait       :string(255)
#

