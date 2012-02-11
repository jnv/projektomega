class Post < ActiveRecord::Base
  belongs_to :character

  validates_presence_of :character, :content
end
