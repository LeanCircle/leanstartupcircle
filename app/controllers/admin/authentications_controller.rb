class Admin::AuthenticationsController < Admin::BaseController

  def index
    @authentications = Authentication.all
  end

  def destroy
    @authentication = Authentication.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url, :notice => "Successfully destroyed authentication."
  end

end
