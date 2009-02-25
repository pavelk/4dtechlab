class FileAtt < ActiveRecord::Base
  
  belongs_to :attachable, :polymorphic => true
  
  has_attached_file :file_att,
                    :url  => "/assets/files/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/files/:id/:style/:basename.:extension"
end
