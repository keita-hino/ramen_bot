Rails.application.routes.draw do
  post '/callback' => 'linebot#callback'
  get '/write' => 'linebot#write'
end
