class Project < ActiveRecord::Base
	belongs_to :user
	
	has_many :assets, inverse_of: :project, dependent: :destroy
	has_many :orders, inverse_of: :project, dependent: :destroy

	validates :user, presence: true
	validates :title, presence: true

	delegate :name, to: :user, prefix: true
end
