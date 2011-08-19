class User < ActiveRecord::Base

  ROLES = %w[admin coordinator user banned]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :role, presence: true, inclusion: {in: ROLES}

end
