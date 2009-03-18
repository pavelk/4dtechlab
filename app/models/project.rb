class Project < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :user
  has_many :comments, :as => :commentary, :dependent => :delete_all
  has_many :photos, :as => :attachable, :dependent => :destroy
  has_many :file_atts, :as => :attachable, :dependent => :destroy
  
  validates_presence_of :title, :perex, :description
  validates_uniqueness_of :title
  
  #indexes for Sphinx
  define_index do
    indexes title
    indexes perex
    indexes description
    indexes user.first_name
    indexes user.last_name
    set_property :delta => true
  end
  
  def to_param
      "#{id}-#{title.parameterize}"
  end
  
  has_attached_file :projectphoto, :styles => { :thumb => "70x66#" },
                    :url  => "/assets/projectphotos/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/projectphotos/:id/:style/:basename.:extension"

  #validates_attachment_presence :avatar
  validates_attachment_size :projectphoto, :less_than => 1.megabytes
  validates_attachment_content_type :projectphoto, :content_type => ['image/jpeg', 'image/png', 'image/gif']
end
