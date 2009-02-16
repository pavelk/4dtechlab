class Notifier < ActionMailer::Base
  default_url_options[:host] = "4dtechlab.com"

  def password_reset_instructions(user)
    subject "Password Reset Instructions"
    from "4d Techlab Notifier <noreply@4dtechlab.com>"
    recipients user.email
    sent_on Time.now
    body :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end
=begin  
  def mail_sent_to_user
    subject "4dtechlab - Vas ucet byl uspesne vytvoren"
    from "4d Techlab Notifier <noreply@4dtechlab.com>"
    recipients user.email
    sent_on Time.now
  end
  
  def mail_sent_to_admin(user)
    subject "4dtechlab - novy ucet"
    from "4d Techlab Notifier <noreply@4dtechlab.com>"
    headers "Reply-to" => "info@4dtechlab.com"
    recipients user.email
    sent_on Time.now
    content_type = "text/plain"
    body[:email] = user.email
  end
=end
end

=begin
  def registration_confirmation( email, password )
    #@recipients   = email
    #@from         = "info@autanasbavi.cz"
    headers         "Reply-to" => "info@autanasbavi.cz"
    #@subject      = "www.autanasbavi.cz"
    #@sent_on      = Time.now
    #@content_type = "text/html"
 
    body[:email] = email
    body[:password] = password
  end
=end  