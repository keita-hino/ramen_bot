Rails.application.routes.draw do
  post '/callback' => 'linebot#callback'
  get '/index' => 'linebot#write'
end
