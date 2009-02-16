class Comment < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :commentary, :polymorphic => true
  
  validates_presence_of :title, :comment
  
end
