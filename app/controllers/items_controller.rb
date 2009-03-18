class ItemsController < ResourceController::Base
  before_filter :load_comments, :only => :show
  before_filter :load_tags
  add_crumb("Library") { |instance| instance.send :libraries_path }
  
  belongs_to :library
    
  create.before :set_user_and_parent
  
  index.wants.html { add_crumb @library.title }
  #new.wants.html { add_crumb "New" }
  #edit.wants.html { add_crumb "Edit #{@item.title}" }
  
  def tag
    @tag = Item.find_tagged_with(params[:id])
  end
  
  def add_photo
    @item = Item.find(params[:id])
    @photo = Photo.new(params[:photo])
    @item.photos << @photo
  
    respond_to do |format|
      format.html { redirect_to(library_item_path(@item.library, @item)) }
    end  
  end
  
  def add_file
    @item = Item.find(params[:id])
    @file = FileAtt.new(params[:file_att])
    @item.file_atts << @file
  
    respond_to do |format|
      format.html { redirect_to(library_item_path(@item.library, @item)) }
    end  
  end
  
  private
    def set_user_and_parent
      @item.user_id = current_user.id
      @item.library_id = @library.id
    end
    
    def collection
      @collection ||= end_of_association_chain.paginate :page => params[:page], :per_page => 10
    end
    
    def load_comments
      @comments = Comment.find(:all, :conditions => ["commentary_id = ? AND commentary_type = ?", params[:id], 'Item' ], :order => 'created_at DESC')
    end
    
    def load_tags
      @tags = Item.tag_counts
    end
end
