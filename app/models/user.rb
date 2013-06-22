class User < ActiveRecord::Base

  class Symbol
    def load(text)
      return unless text
      text.to_sym
    end

    def dump(text)
      text.to_s
    end
  end

  has_one :character

  #ROLES = %w[admin coordinator user banned guest]
  ROLES = [:admin, :coordinator, :user, :banned] #, :guest]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :role

  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :role, presence: true, inclusion: {in: ROLES}

  serialize :role, Symbol.new

  def role
    read_attribute(:role).to_sym
  end

  def role=(new_role)
    write_attribute :role, new_role.to_s
  end

  def to_s
    name
  end


end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)      not null
#  role                   :string(255)      default("user"), not null
#

