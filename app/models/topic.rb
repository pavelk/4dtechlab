class Topic < ActiveRecord::Base
  
  belongs_to :forum, :counter_cache => true 
  belongs_to :user
  has_many :posts, :dependent => :nullify
  has_one  :recent_post, :order => "created_at DESC", :class_name => 'Post'
  
  validates_presence_of :title 
  validates_length_of :title, :maximum => 255 
  
  def hit!
    self.class.increment_counter :hits, id
  end  
    
  def to_param
      "#{id}-#{title.parameterize}"
  end
  
end
