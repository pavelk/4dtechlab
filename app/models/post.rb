class Post < ActiveRecord::Base
  
  belongs_to :topic, :counter_cache => true 
  belongs_to :user, :counter_cache => true
  
  validates_presence_of :body 
  validates_length_of :body, :maximum => 10000
  
  define_index do
    indexes body
    indexes user.first_name
    indexes user.last_name
  end
  
  named_scope :new_posted, :limit => 10, :order => 'created_at DESC'
  
end
