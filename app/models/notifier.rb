class Notifier < ActionMailer::Base
  default_url_options[:host] = "4dtechlab.com"

  #reset instructions
  def password_reset_instructions(user)
    subject "Password Reset Instructions"
    from "4d Techlab Notifier <noreply@4dtechlab.com>"
    recipients user.email
    sent_on Time.now
    body :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

  #after registration
  def mail_sent_to_user(user)
    subject "4dtechlab - Vas ucet byl uspesne vytvoren"
    from "4d Techlab Notifier <noreply@4dtechlab.com>"
    recipients user.email
    sent_on Time.now
    body[:email] = user.email
  end
  
  #after registration to admin
  def mail_sent_to_admin(user)
    subject "4dtechlab - novy ucet"
    from "4d Techlab Notifier <noreply@4dtechlab.com>"
    headers "Reply-to" => "info@4dtechlab.com"
    recipients 'pavel.krusek@gmail.com'
    sent_on Time.now
    #content_type = "text/plain"
    body :user_url => user_path(user)
  end
  
#  def activation(user)
#    subject "4dtechlab - aktivace uctu"
#    from "4d Techlab Notifier <noreply@4dtechlab.com>"
#    headers "Reply-to" => "info@4dtechlab.com"
#    recipients user.email
#    sent_on Time.now
#  end
end
deliver_activation
