class Asset < ActiveRecord::Base
  belongs_to :project

  validates :project, presence: true
  validates :title, presence: true
  validates :filepicker_url, presence: true

  delegate :title, to: :project, prefix: true
end
