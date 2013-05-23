# gollum configuration
require 'gollum/frontend/app'
require 'warden'
require 'json'
require 'debugger'
 
# =============
#    Const
# =============

class << Leanstartupcircle::Application
  def inherited(base)
  end
end
 
class AppMain < Sinatra::Application
  Precious::App.set :gollum_path, Rails.root.join('db', 'wiki')
  Precious::App.set :default_markup, :markdown
 
  get '/Home' do
    Precious::App.set :wiki_options, {:live_preview => false,
                                      :user_can_delete => user_can_delete,
                                      :user_can_create => user_can_create,
                                      :user_can_update => user_can_update }
    redirect "/wiki-leanstartup"
  end

  def user_can_delete
    env['warden'].authenticated? && env['warden'].user.role == "admin"
  end

  def user_can_create
    env['warden'].authenticated? && (env['warden'].user.role == "admin" || env['warden'].user.role == "editor")
  end

  def user_can_update
    env['warden'].authenticated? && (env['warden'].user.role == "admin" || env['warden'].user.role == "editor")
  end
 
  # -------------
  #     Auth
  # -------------
  # See, from https://gist.github.com/217362
  post '/unauthenticated/?' do
    options = env['warden.options'] || {}
    code = options[:code] || 401
    message = options[:message] || 'User is not logged in.'
      
    json = {
      :code => code,
        :message => message,
        :options => options
    }
    halt code, JSON.generate(json)

  end

  get '/logout/?' do
    env['warden'].logout
    redirect '/wiki'
  end
 
end