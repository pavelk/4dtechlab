class Event < ActiveRecord::Base
  acts_as_taggable
  
  def self.per_page
    10
  end
  
  belongs_to :user
  has_many :comments, :as => :commentary, :dependent => :delete_all
  has_many :photos, :as => :attachable, :dependent => :destroy
  #has_many :file_atts, :as => :attachable, :dependent => :destroy
  
  validates_presence_of :title, :perex, :event_date, :location, :description
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
  
  named_scope :period_events,
              lambda { |date_from, date_until| { :conditions => ['event_date >= ? and event_date <= ?',
                                                 date_from, date_until] } }
                                                 
  def self.monthly_events(date)
    self.period_events(date.beginning_of_month, date.to_time.end_of_month)
  end
  
  def self.daily_events(date)
    self.period_events(date.beginning_of_day, date.to_time.end_of_day)
  end                                                 
  
  def to_param
      "#{id}-#{title.parameterize}"
  end
  
  has_attached_file :eventphoto, :styles => { :thumb => "70x66#" },
                    :url  => "/assets/eventphotos/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/eventphotos/:id/:style/:basename.:extension"

  #validates_attachment_presence :avatar
  validates_attachment_size :eventphoto, :less_than => 1.megabytes
  validates_attachment_content_type :eventphoto, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  
end