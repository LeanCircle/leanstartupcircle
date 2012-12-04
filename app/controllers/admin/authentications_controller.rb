class Admin::AuthenticationsController < Admin::BaseController
  load_and_authorize_resource

  def index
    @authentications = Authentication.all
  end

  def destroy
    @authentication = Authentication.find(params[:id])
    @authentication.destroy
    redirect_to admin_authentications_url, :notice => "Successfully destroyed authentication."
  end

end
