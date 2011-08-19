class Character < ActiveRecord::Base

  belongs_to :user

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
