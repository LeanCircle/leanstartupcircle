# gollum configuration
require 'gollum/frontend/app'
Precious::App.set :gollum_path, Rails.root.join('db', 'wiki')
Precious::App.set :default_markup, :markdown
Precious::App.set :wiki_options, {:live_preview => false}
