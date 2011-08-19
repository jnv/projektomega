class Character < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :number, :name
  validates :number, uniqueness: true, numericality: {only_integer: true, greater_than: 0}

  alias_method :abbr, :code
  def code
    "A#{number}"
  end

  def full_name
    "#{abbr} #{name}"
  end

  def to_s
    name
  end

end
