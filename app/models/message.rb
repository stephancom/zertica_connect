class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin

  validates :user, presence: true
  validates :body, presence: true
  # validate user owns project or is admin?

  default_scope order('created_at ASC').includes(:user, :admin)
  scope :bookmarked, -> { where(bookmark: true) }

  after_commit :push_add_message, on: :create
  after_commit :push_update_message, on: :update

  delegate :name, to: :admin, prefix: true, allow_nil: true
  delegate :name, to: :user, prefix: true

private

	def push_add_message
		MessagesPusher.new(user).add_message(self).push
	end

	def push_update_message
		MessagesPusher.new(user).update_message(self).push
	end
end
