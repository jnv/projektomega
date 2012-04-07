class Post < ActiveRecord::Base
  belongs_to :character
  attr_readonly :character

  validates_presence_of :character, :content
end
