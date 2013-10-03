class ProjectFile < ActiveRecord::Base
  belongs_to :project

  validates :url, presence: true

  delegate :title, to: :project, prefix: true

  has_and_belongs_to_many :orders

  alias_attribute :name, :filename
end
