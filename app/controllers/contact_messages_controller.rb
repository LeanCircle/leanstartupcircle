class ContactMessagesController < ApplicationController

  def new
    @contact_message = ContactMessage.new
  end

  def create
    if params[:commit].eql?('Cancel')
      redirect_to root_url
    else
      @contact_message = ContactMessage.new(params[:contact_message])
      if @contact_message.valid? && verify_recaptcha(:model => @contact_message, :attribute => "recaptcha", :message => "Damn you reCAPTCHA!")
        UserMailer.contact_us(@contact_message).deliver
        flash[:success] = 'Your message has been sent! We\'ll reply as soon as possible.'
        redirect_to(contact_thanks_url)
      else
        render :action => 'new'
      end
    end
  end

  def thanks
  end

end
