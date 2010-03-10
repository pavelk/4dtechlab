#ENV['RAILS_ENV'] ||= 'production'

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  
  config.gem 'authlogic',
             :version => '~> 2.1.2'
  config.gem 'thoughtbot-paperclip', :lib => 'paperclip', :source => 'http://gems.github.com'           
  
  config.time_zone = 'UTC'

  config.i18n.load_path = Dir[File.join(RAILS_ROOT, 'config', 'locales', '*.{rb,yml}')]
  config.i18n.default_locale = :en

=begin
  config.action_controller.session = {
    :session_key => '_techlab_session',
    :secret      => 'c13bce14a78db6da1fbde83272fd7c6d10dcb228e14771357168d1ff324043a5e0818535170d7c89ed50e591a1396738429dc53d110def2ddddf177c6eb49a47'
  }
=end  

  config.action_controller.session_store = :active_record_store

end
Haml::Template.options[:ugly] = false
#ThinkingSphinx::Configuration.instance.load_models
