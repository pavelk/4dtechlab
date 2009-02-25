class Event < ActiveRecord::Base
  acts_as_taggable
  
  def self.per_page
    4
  end
  
  belongs_to :user
  has_many :comments, :as => :commentary, :dependent => :delete_all
  has_many :photos, :as => :attachable, :dependent => :destroy
  
  validates_presence_of :title, :perex
  validates_uniqueness_of :title
  
  #indexes for Sphinx
  define_index do
    indexes title
    indexes perex
    indexes description
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
  
end