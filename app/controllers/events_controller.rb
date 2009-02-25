class EventsController < ResourceController::Base
    
  before_filter :load_date, :only => [:index, :show, :tag]
  before_filter :load_events, :only => [:index, :show, :tag]
  before_filter :load_comments, :only => :show
  
  create.before :set_user
  
  def index
    add_crumb("Events")
    @events = @month_events.paginate :page => params[:page]
  end
  
  def show
    if filter_by_calendar?
      events = Event.daily_events(@date)
      if(events.size > 1)
        @events = events.paginate :page => params[:page]
        render :action => "index"
      else
        @event = Event.find(events.first.id)
      end
    else
      @event = Event.find(params[:id])     
    end
  end

  def add_photo
    @event = Event.find(params[:id])
    @photo = Photo.new(params[:photo])
    @event.photos << @photo
  
    respond_to do |format|
      format.html { redirect_to(@event) }
    end  
  end
 
  def tag
    @tag = Event.find_tagged_with(params[:id])
  end    
     
  private
    def set_user
      @event.user_id = current_user.id
    end
    
    def load_date
      now   = Time.now
      year  = (params[:year]  || now.year).to_i
      month = (params[:month] || now.month).to_i
      day   = (params[:day]   || now.mday).to_i
      @date = DateTime.new(year, month, day)
      rescue ArgumentError
        @date = Time.now
    end
    
    def load_events
      @month_events = Event.monthly_events(@date)
      @tags = Event.tag_counts # returns all the tags used
    end  
    
    def load_comments
      @comments = Comment.find(:all, :conditions => ["commentary_id = ? AND commentary_type = ?", params[:id], 'Event' ], :order => 'created_at DESC')
    end  
    
    def filter_by_calendar?
      params[:id].nil?
    end        
  
end