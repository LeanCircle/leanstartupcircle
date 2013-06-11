class MyDevise::ConfirmationsController < Devise::ConfirmationsController
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    if resource.errors.empty?
      set_flash_message(:notice, :confirmed)
      sign_in(resource_name, resource)
      redirect_to after_confirmation_path_for(resource_name, resource)
    else
      render :new 
    end
  end

end
