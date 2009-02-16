class HelpsController < ResourceController::Base
  before_filter :load_comments, :only => :show
  
  def sidebar_menu
    "sidebarmenu_help"
  end 
  
  index.wants.html { add_crumb("Help") }
  #new.wants.html { add_crumb("Help", collection_url) }
  show.wants.html do
     @help.hit!
     add_crumb("Help", collection_url)
     add_crumb(@help.title)     
  end
  
  edit.wants.html do
     add_crumb("Help", collection_url)
     add_crumb(@help.title)     
  end
  
  
  
#  [new, show].each do |action|
#      action.wants.html { add_crumb("Help") }
#      action.wants.html { add_crumb(@help.title, helps_path) }
#  end

  private
    
    def load_comments
      @comments = Comment.find(:all, :conditions => ["commentary_id = ? AND commentary_type = ?", params[:id], 'Help' ], :order => 'created_at DESC')
    end

    def collection
      @collection ||= end_of_association_chain.paginate :page => params[:page], :per_page => 10
    end  

end
