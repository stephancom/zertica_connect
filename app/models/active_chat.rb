class ActiveChat < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin

  validates :user_id, uniqueness: {scope: :admin_id}, presence: true
  validates :admin_id, uniqueness: {scope: :user_id}, presence: true

  delegate :name, to: :user
  delegate :name, to: :admin, prefix: true
end
