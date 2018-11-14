Rails.application.routes.draw do
  post '/callback' => 'linebot#callback'
  get '/new' => 'linebot#new'
  post '/foodrecords' => 'linebot#create'
end
