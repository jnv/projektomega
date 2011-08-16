class Character < ActiveRecord::Base

  validates_presence_of :number, :name
  validates :number, uniqueness: true, numericality: {only_integer: true, greater_than: 0}

end
