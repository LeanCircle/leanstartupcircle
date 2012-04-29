Leanstartupcircle::Application.routes.draw do
  root :to => redirect("https://groups.google.com/forum/?fromgroups#!forum/lean-startup-circle")
  match "faq.html" => "static_pages#guidelines"
  match "faq" => "static_pages#guidelines"
  match "guidelines" => "static_pages#guidelines"
  match "team" => "static_pages#team"
end