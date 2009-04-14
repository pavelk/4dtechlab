class CommentsController < ResourceController::Base
  
  belongs_to :event, :item, :project
  
  create.before :set_user
  
  #redirect to the parent post's show method 
  #create.wants.html { redirect_to smart_url(parent_url_options) }
  create.wants.html do
    #CGI::escapeHTML(params[:comment][:comment])
    redirect_to smart_url(parent_url_options)
  end  
  
  private
    def set_user
      @comment.user_id = current_user.id
    end
  
end
