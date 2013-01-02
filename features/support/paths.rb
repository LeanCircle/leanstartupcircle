module NavigationHelpers
  def path_to(page_name)
    case page_name

    # Add more page name => path mappings here
      when /the home\s?page/
        '/'
      when /the list of groups/
        groups_path
      when /the new group form/
        new_group_path
      when /the sign in form/
        sign_in_path

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)