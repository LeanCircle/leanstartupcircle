DynamicSitemaps::Sitemap.draw do

  url root_url, :last_mod => DateTime.now, :change_freq => 'daily', :priority => 1

  # Groups routes
  url groups_url, :changefreq => 'weekly', :priority => 1
  url new_group_url, :changefreq => 'weekly', :priority => 1
  Group.find_each do |group|
    url group_url(group), :lastmod => group.updated_at, :changefreq => 'monthly', :priority => 0.8
  end

  # Jobs routes
  url jobs_url, :changefreq => 'monthly', :priority => 0.5

  #autogenerate  :groups,
  #              :last_mod => :updated_at,
  #              :change_freq => 'monthly',
  #              :priority => 0.8

  # Forum routes
  url guidelines_path, :changefreq => 'yearly', :priority => 0.5
  url moderation_guidelines_path, :changefreq => 'yearly', :priority => 0.5

  # About pages
  url team_path, :changefreq => 'yearly', :priority => 0.5

  # Contact message routes
  url contact_path, :changefreq => 'yearly', :priority => 0.1
  url contact_thanks_path, :changefreq => 'yearly', :priority => 0.1

  # TODO: Figure out how to do subdomains with sitemap.
end