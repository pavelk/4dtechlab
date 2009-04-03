class HomeController < ApplicationController
  before_filter :load_date, :only => [:index, :show, :tag]
  
  def index
    @tags = Item.tag_counts + Event.tag_counts
    @month_events = Event.monthly_events(@date)
    #@items = ActiveRecord::Base.connection.select_all("SELECT id, title, perex, created_at
    @items = Event.find_by_sql("SELECT id, title, perex, created_at, user_id, eventphoto_file_name, @type:='EVENT' AS typ
                                FROM events 
                                UNION 
                                SELECT id, title, perex, created_at, user_id, projectphoto_file_name, @type:='PROJECT' AS typ
                                FROM projects
                                UNION
                                SELECT id, title, perex, created_at, user_id, itemphoto_file_name, @type:='ITEM' AS typ
                                FROM items
                                UNION
                                SELECT id, first_name, last_name, created_at, login, email, @type:='USER' AS typ
                                FROM users
                                ORDER BY created_at DESC
                                LIMIT 10"
                              )                       
                                
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