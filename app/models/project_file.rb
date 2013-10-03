class ProjectFile < ActiveRecord::Base
  belongs_to :project

  validates :url, presence: true

  delegate :title, to: :project, prefix: true
end
