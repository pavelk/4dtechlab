class ForumsController < ResourceController::Base  
  add_crumb("Forums")
    
  [create, update].each { |action| action.wants.html { redirect_to forums_path } } 

end