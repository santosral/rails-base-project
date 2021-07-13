Rails.application.routes.draw do
  resources :foods  
  get '/api-fetch' => 'foods#api_fetch', as: 'api_fetch'
end
