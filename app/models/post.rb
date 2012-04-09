class Post < ActiveRecord::Base
  belongs_to :character
  attr_readonly :character

  validates_presence_of :character, :content

  default_scope :order => 'created_at DESC'
end
