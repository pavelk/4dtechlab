class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :library
  has_many :comments, :as => :commentary, :dependent => :delete_all
  has_many :photos, :as => :attachable, :dependent => :destroy
  has_many :file_atts, :as => :attachable, :dependent => :destroy
  
  validates_presence_of :title, :perex, :description
  validates_uniqueness_of :title
  
  acts_as_taggable
  
  #indexes for Sphinx
=begin  
  define_index do
    indexes title
    indexes perex
    indexes description
    set_property :delta => true
  end
=end  
  def to_param
      "#{id}-#{title.parameterize}"
  end
  
  has_attached_file :itemphoto, :styles => { :thumb => "70x66#" },
                    :url  => "/assets/itemphotos/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/itemphotos/:id/:style/:basename.:extension"

  #validates_attachment_presence :avatar
  #validates_attachment_size :itemphoto, :less_than => 1.megabytes
  #validates_attachment_content_type :itemphoto, :content_type => ['image/jpeg', 'image/png', 'image/gif']
end