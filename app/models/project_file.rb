class ProjectFile < ActiveRecord::Base
  belongs_to :project

  validates :url, presence: true

  delegate :title, to: :project, prefix: true

  def name
'foo' #  	@name ||= data[:filename]
  end

  def size
'bar' #  	@size ||= data[:size]  	
  end

  def type
'baz' #  	@type ||= data[:type]  	
  end
end
