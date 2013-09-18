class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :sender, class_name: User

  validates :user, presence: true
  validates :body, presence: true
  # validate user owns project or is admin?

  scope :bookmarked, -> { where(bookmark: true) }
end
