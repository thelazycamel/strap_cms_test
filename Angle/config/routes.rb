Rails.application.routes.draw do

  # defaults to dashboard
  root :to => redirect('/singleview')

  # view routes
  get '/singleview' => 'singleview#index'
  get "/charts" => "singleview#charts"
  get "/widgets" => "singleview#widgets"
  get "/post" => "singleview#post"

  # api routes
  get '/api/i18n/:locale' => 'api#i18n'

  resources :books


end
