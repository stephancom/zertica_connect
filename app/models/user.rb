class User < ActiveRecord::Base
	rolify
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

	has_many :projects, dependent: :destroy
	has_many :messages, dependent: :destroy

	scope :clients, -> { where('id NOT IN (?)', with_role(:admin)) }

	def pusher_key
	"user_#{id}"
	end
end