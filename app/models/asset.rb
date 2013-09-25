class Asset < ActiveRecord::Base
  belongs_to :project

  validates :title, presence: true

  delegate :title, to: :project, prefix: true
end
