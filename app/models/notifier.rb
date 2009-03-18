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
    subject "4D Techlab - Thank you for registration"
    from "4d Techlab Notifier <noreply@4dtechlab.com>"
    headers "Reply-to" => "noreply@4dtechlab.com"
    recipients user.email
    sent_on Time.now
    body[:first_name] = user.first_name
  end
  
  #after registration to admin
  def mail_sent_to_admin(user)
    subject "4D Techlab - New user"
    from "4d Techlab Notifier <noreply@4dtechlab.com>"
    headers "Reply-to" => "info@4dtechlab.com"
    recipients 'pavel.krusek@gmail.com'
    sent_on Time.now
    #content_type = "text/plain"
    body :user_url => user_url(user)
  end
  
  #after activation
  def activation_info_to_user(user)
    subject "4D Techlab - Your membership just has been approved"
    from "4d Techlab Notifier <noreply@4dtechlab.com>"
    headers "Reply-to" => "info@4dtechlab.com"
    recipients user.email
    sent_on Time.now
    #content_type = "text/plain"
    body[:first_name] = user.first_name
  end

  #after deactivation
  def deactivation_info_to_user(user)
    subject "4D Techlab - Account on hold"
    from "4d Techlab Notifier <noreply@4dtechlab.com>"
    headers "Reply-to" => "info@4dtechlab.com"
    recipients user.email
    sent_on Time.now
    #content_type = "text/plain"
    body[:first_name] = user.first_name
  end
  
    #after question
  def new_question_to_admin(user, question)
    subject "4D Techlab - Question"
    from "4d Techlab Notifier <noreply@4dtechlab.com>"
    headers "Reply-to" => "info@4dtechlab.com"
    recipients 'pavel.krusek@gmail.com'
    sent_on Time.now
    #content_type = "text/plain"
    body[:user_name] = user.full_name
    body[:question_title] = question.title
    body[:question_perex] = question.perex
    body[:question_url] = question_url(question)
  end

end