class UsersController < ApplicationController
  before_filter :authenticate_user!

  def sign_up
    @user = current_user
  end

  def register
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to thanks_for_signing_up_url }
        format.json { head :no_content }
      else
        format.html { render action: "sign_up" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end