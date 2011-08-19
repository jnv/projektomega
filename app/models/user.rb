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

  #ROLES = %w[admin coordinator user banned]
  ROLES = [:admin, :coordinator, :user, :banned]

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


end
