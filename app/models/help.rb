class Help < ActiveRecord::Base
  has_many :comments, :as => :commentary, :dependent => :delete_all
  
  validates_presence_of :title, :perex
  validates_uniqueness_of :title
  
  named_scope :most, :limit => 5, :order => 'hits DESC'
  
  def hit!
    self.class.increment_counter :hits, id
  end
  
  #indexes for Sphinx
  define_index do
    indexes title
    indexes perex
    indexes description
    set_property :delta => true
  end
  
  def to_param
      "#{id}-#{title.parameterize}"
  end
end
