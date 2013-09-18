class Message < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates :body, presence: true
  # validate user owns project or is admin?
  
end
