class MyDevise::RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(sign_up_params)
    if resource.save
      if session["auth"] # Assign auth to user.
        resource.authentications << session["auth"]
        resource.groups << session["auth"].groups unless session["auth"].groups.blank?
        set_flash_message :notice, :groups_were_imported
      end
      if session['group_to_assign']
        group = Group.find(session["group_to_assign"])
        resource.groups << group
      end
      if resource.active_for_authentication?
        if session["auth"] || session['group_to_assign']
          set_flash_message :notice, :signed_up_groups_imported
        elsif is_navigational_format?
          set_flash_message :notice, :signed_up
        end
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
      session["auth"] = nil
      session["group_to_assign"] = nil
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def provide_email
    resource = build_resource()
    resource.name = session["auth"].name
    set_flash_message :notice, :groups_need_approval
    respond_with resource
  end

  def new
    resource = build_resource({})
    respond_with resource
  end

end