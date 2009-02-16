class PostsController < ResourceController::Base
  belongs_to :topic
  
  before_filter :load_forum_and_set_crumbs    
  
  create.before :set_user
  
  create.wants.html { redirect_to forum_topic_posts_path(params[:forum_id],@topic) }
     
  index.wants.html do
     @topic.hit!
     add_crumb(@topic.title) 
  end   
  
=begin
      TODO
      redirect show to collection
=end  
  
  private
    def set_user
      @post.user_id = current_user.id
    end
    
    def load_forum_and_set_crumbs
      @forum = Forum.find(params[:forum_id])
      add_crumb("Forums", forums_path)
      add_crumb(@forum.title, forum_topics_path(@forum))
    end  
end
