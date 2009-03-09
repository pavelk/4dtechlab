class HomeController < ApplicationController
  before_filter :load_date, :only => [:index, :show, :tag]
  
  def index
    @tags = Item.tag_counts + Event.tag_counts
    @month_events = Event.monthly_events(@date)
  end
  
  def tag
    @tags = Item.tag_counts + Event.tag_counts
    @tag = Event.find_tagged_with(params[:id]) + Item.find_tagged_with(params[:id])
    @month_events = Event.monthly_events(@date)
  end
  
  
  private
    def load_date
      now   = Time.now
      year  = (params[:year]  || now.year).to_i
      month = (params[:month] || now.month).to_i
      day   = (params[:day]   || now.mday).to_i
      @date = DateTime.new(year, month, day)
      rescue ArgumentError
        @date = Time.now
    end    
  
end