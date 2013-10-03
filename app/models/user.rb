class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

	has_many :projects, dependent: :destroy
	has_many :messages, dependent: :destroy
	has_many :active_chats, dependent: :destroy
	has_many :orders, through: :projects

	def message_channel
		"/messages/new/#{id}"
	end
end