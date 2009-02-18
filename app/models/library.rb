class Library < ActiveRecord::Base
  acts_as_nested_set
  
  has_many :items, :dependent => :nullify
  belongs_to :user
  
  def to_param
    "#{id}-#{title.parameterize}"
  end
end
