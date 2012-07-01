class UserMailer < ActionMailer::Base

  default :from => "no-reply@leanstartupcircle.com"

  def contact_us(contact_message)
    @contact_message = contact_message
    mail :to => "feedback@leanstartupcircle.com",
         :from => "no-reply@leanstartupcircle.com",
         :reply_to => @contact_message.sender,
         :subject => "Message sent via the LeanStartupCircle.com contact form"
  end

end
