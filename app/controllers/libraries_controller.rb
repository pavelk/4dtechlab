class LibrariesController < ResourceController::Base
  before_filter :load_tags
  add_crumb("Library")
#  def sub_menu
#    "submenu_libraries"
#  end
  create.after :set_level
  
#  def create
#    sds
#  end
  def index
    @libraries = Library.all
    @items = Item.all.paginate :page => params[:page], :per_page => 10
  end
  
  def tag
    @tag = Item.find_tagged_with(params[:id])
  end  
  
  private
    
    def set_level
      if params[:library][:parent_id] != ""
        parent = Library.find(params[:library][:parent_id])
        @library.move_to_child_of(parent)
      end
    end
    
    def load_tags
      @tags = Item.tag_counts
    end
  
end
