class Forum < ActiveRecord::Base
  
  #
  has_many :topics, :dependent => :nullify
  has_many :posts, :through => :topics
  has_one  :recent_post, :through => :topics, :source => :posts, :order => "created_at DESC"
  
  validates_presence_of :title 
  validates_length_of :title, :maximum => 255 
  validates_length_of :perex, :maximum => 1000 
  
  def to_param
      "#{id}-#{title.parameterize}"
  end
  
end