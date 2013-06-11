class MyDevise::RegistrationsController < Devise::RegistrationsController

  def create
    build_resource
    if resource.save
      if session["auth"] # Assign auth to user.
        resource.authentications << session["auth"]
        assign_group_to_user(resource, session["auth"].groups) unless session["auth"].groups.blank?
        resource.groups << session["auth"].groups unless session["auth"].groups.blank?
        session["auth"] = nil
      end
      if session['group_to_assign']
        group = Group.find(session["group_to_assign"])
        resource.groups << group
        session["group_to_assign"] = nil
      end
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
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