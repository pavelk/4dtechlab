class Comment < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :commentary, :polymorphic => true
  
  validates_presence_of :title, :comment
  
  #indexes for Sphinx
  define_index do
    indexes title
    indexes comment
    set_property :delta => true
  end
  
end
