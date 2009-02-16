class Right < ActiveRecord::Base
  has_and_belongs_to_many :roles
  
  def has_right_for?(action_name, controller_name)
    action == action_name && controller == controller_name
  end
end
