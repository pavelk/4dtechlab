class Question < ActiveRecord::Base
  
  belongs_to :user
  
  def deliver_new_question_to_admin(user)
    Notifier.deliver_new_question_to_admin(user, self)
  end
  
end
