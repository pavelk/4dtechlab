class User < ActiveRecord::Base
  
  acts_as_taggable
  
  has_many :events, :dependent => :nullify
  has_many :questions, :dependent => :nullify
  has_and_belongs_to_many :roles
  
  #acts_as_authentic :login_field_type => 'email', :login_field => 'email'
  acts_as_authentic do |c|
    c.login_field = 'email'
    #c.validates_length_of_password_field_options = { :minimum => 5 }
  end
  
  validates_presence_of :first_name, :last_name, :agency
  
  #indexes for Sphinx
=begin  
  define_index do
    indexes email
    indexes first_name
    indexes last_name
    set_property :delta => true
  end
=end  
   
  named_scope :new_registered, :limit => 10, :order => 'created_at DESC'
  
  def has_role?(role_in_question)
    @_list ||= self.roles.collect(&:name)
    return true if @_list.include?("admin")
    (@_list.include?(role_in_question.to_s) )
  end
  
  def has_right_for?(action_name, controller_name)
    roles.detect{ |role| role.has_right_for?(action_name, controller_name) }
  end
  
#  def approved?
#    self.approved ? true : false    
#  end  
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end

  def deliver_init_mail_to_user
    Notifier.deliver_mail_sent_to_user(self)
  end
  
  def deliver_init_mail_to_admin
    Notifier.deliver_mail_sent_to_admin(self)
  end
  
  def deliver_activation_info_to_user
    Notifier.deliver_activation_info_to_user(self)
  end
  
  def deliver_deactivation_info_to_user
    Notifier.deliver_deactivation_info_to_user(self)
  end

  
  has_attached_file :avatar, :styles => { :small => "78x100#", :forum => "47x60#" },
                    :url  => "/assets/avatars/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/avatars/:id/:style/:basename.:extension"

  #validates_attachment_presence :avatar
  validates_attachment_size :avatar, :less_than => 1.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  
  
  def full_name 
    [first_name, last_name].join(" ") 
  end
end