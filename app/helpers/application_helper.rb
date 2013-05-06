module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def on_heroku?
    ENV['ON_HEROKU']
  end
end
