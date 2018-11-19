Rails.application.routes.draw do
  post '/callback' => 'linebot#callback'
  get '/new' => 'linebot#new'
  get '/search' => 'linebot#search'
  post '/foodrecords' => 'linebot#create'
  get '/show' => 'linebot#show'
end
