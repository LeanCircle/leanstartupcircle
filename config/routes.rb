Leanstartupcircle::Application.routes.draw do
  root :to => redirect("https://groups.google.com/forum/?fromgroups#!forum/lean-startup-circle")
  match "faq.html" => "landing_pages#faq"
  match "faq" => "landing_pages#faq"
end