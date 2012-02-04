class Post < ActiveRecord::Base
  belongs_to :character
  belongs_to :user

  validates_presence_of :content
end
