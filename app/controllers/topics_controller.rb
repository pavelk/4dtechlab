class TopicsController < ResourceController::Base

  add_crumb("Forums") { |instance| instance.send :forums_path }
  
  belongs_to :forum
  
  create.before :set_user
  create.after  :save_first_post
  
  [create, update].each { |action| action.wants.html { redirect_to forum_topic_posts_path(@forum,@topic) } }
  index.wants.html { add_crumb @forum.title }
  
  protected
    def set_active_tab
      @active_tab = :users
    end
  
  private
    def set_user
      @topic.user_id = current_user.id
    end
    
    def save_first_post
      @post = Post.new(:body => params[:post][:body], 
                       :topic_id => @topic.id, 
                       :user_id => current_user)
      @post.save!
    end

    def collection
      @collection ||= end_of_association_chain.paginate :page => params[:page], :per_page => 5
    end
      
  
end
