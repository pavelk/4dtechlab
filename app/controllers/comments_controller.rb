class CommentsController < ResourceController::Base
  
  belongs_to :event, :item
  
  create.before :set_user
  
  #redirect to the parent post's show method 
  create.wants.html { redirect_to smart_url(parent_url_options) }

  private
    def set_user
      @comment.user_id = current_user.id
    end
  
end
