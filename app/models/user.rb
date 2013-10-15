class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

	has_many :projects, dependent: :destroy
	has_many :messages, dependent: :destroy
	has_many :active_chats, dependent: :destroy
	has_many :orders, through: :projects

	def message_channel
		"/messages/new/#{id}"
	end

	def first_name
		name.split(' ').first
	end

	def last_name
		name.split(' ').last
	end

	def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
		user = User.where(provider: auth.provider, uid: auth.uid).first
		user ||= User.where(email: auth.info.email).first_or_create do |user|
			user.uid = auth.uid
			user.provider = auth.provider
			user.name ||= auth.extra.raw_info.name
			user.password ||= Devise.friendly_token[0,20]
		end
		user
	end
end