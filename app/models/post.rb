class Post < ActiveRecord::Base
  belongs_to :character
  attr_readonly :character

  validates_presence_of :character, :content

  default_scope :order => 'created_at DESC'
end

# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  character_id :integer          not null
#  content      :text             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

