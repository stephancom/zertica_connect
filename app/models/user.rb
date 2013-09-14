class User < ActiveRecord::Base
	rolify
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

	validates :email, uniqueness: true

	has_many :projects
end