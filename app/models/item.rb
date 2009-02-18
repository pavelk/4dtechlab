class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :library
  has_many :comments, :as => :commentary, :dependent => :delete_all
  
  validates_presence_of :title, :perex
  validates_uniqueness_of :title
  
  acts_as_taggable
  
  def to_param
      "#{id}-#{title.parameterize}"
  end
end