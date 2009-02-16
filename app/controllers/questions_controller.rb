class QuestionsController < ResourceController::Base
  belongs_to :help
  
  def sidebar_menu
    "sidebarmenu_questions"
  end 
  
  create.before :set_user
  
  #[create, update].each { |action| action.wants.html { redirect_to forum_topic_posts_path(@forum,@topic) } }
#  index.wants.html do
#    @questions = Question.all(:conditions => 'active = false')
#  end

  def index
    @questions = Question.all(:conditions => 'active = false')
  end
  
  def answered
    @questions = Question.all(:conditions => 'active = true AND solved = false')
    add_crumb('Questions', questions_path)
    add_crumb('Answered')
    render :action => "index" 
  end
  
  def solved
    @question = Question.find(params[:id])
    @question.solved = true
    @question.save!
    @help = Help.new(:title => params[:question][:title], 
                     :perex => params[:question][:perex], 
                     :description => params[:question][:description])
    @help.save!
    redirect_to answered_path
  end
  
  create.wants.html do
    flash "Thank you for your question!"
    redirect_to helps_path 
  end
  
  private
    def set_user
      @question.user_id = current_user.id
    end
  
end