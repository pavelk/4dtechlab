class ProjectsController < ResourceController::Base
  before_filter :load_date, :only => [:index, :show, :tag]
  before_filter :load_tags, :only => [:show, :index, :tag]
  before_filter :load_comments, :only => :show
  
  create.before :set_user
  
  def index
    #@tags = Item.tag_counts + Event.tag_counts
    @month_events = Event.monthly_events(@date)
    @projects = Project.all.paginate :page => params[:page], :per_page => 10
  end
  
  def show
    @project = Project.find(params[:id])  
    @events = Event.monthly_events(@date)
  end
  
  def add_photo
    @project = Project.find(params[:id])
    @photo = Photo.new(params[:photo])
    @project.photos << @photo
  
    respond_to do |format|
      format.html { redirect_to(@project) }
    end  
  end
  
  def add_file
    @project = Project.find(params[:id])
    @file = FileAtt.new(params[:file_att])
    @project.file_atts << @file
  
    respond_to do |format|
      format.html { redirect_to(@project) }
    end  
  end
  
  def tag
    @month_events = Event.monthly_events(@date)
    @tag = Project.find_tagged_with(params[:id])
  end
  
  private
  
    def set_user
      @project.user_id = current_user.id
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
    
    def load_tags
      @tags = Project.tag_counts # returns all the tags used
    end

    def load_comments
      @comments = Comment.find(:all, :conditions => ["commentary_id = ? AND commentary_type = ?", params[:id], 'Project' ], :order => 'created_at DESC')
    end    
#    def collection
#      @collection ||= end_of_association_chain.paginate :page => params[:page], :per_page => 10
#    end
end
