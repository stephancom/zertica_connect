class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :sender, class_name: User

  validates :user, presence: true
  validates :body, presence: true
  # validate user owns project or is admin?

  default_scope order('created_at ASC').includes(:sender)
  scope :bookmarked, -> { where(bookmark: true) }

  after_commit :push_add_message, on: :create
  after_commit :push_update_message, on: :update

  delegate :name, to: :sender, prefix: true
  delegate :name, to: :user, prefix: true

private

	def push_add_message
		MessagesPusher.new(user).add_message(self).push
		# this is a sleazy interim solution - we just push the message to EVERY admin
		# not a great solution....
		User.with_role(:admin).each do |this_admin|		
			MessagesPusher.new(this_admin).add_message(self).push unless this_admin == user
		end
	end

	def push_update_message
		MessagesPusher.new(user).update_message(self).push
		# ditto.  See above
		User.with_role(:admin).each do |this_admin|		
			MessagesPusher.new(this_admin).update_message(self).push unless this_admin == user
		end
	end
end
