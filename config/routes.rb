Rails.application.routes.draw do
<<<<<<< HEAD
  devise_for :admins
  devise_for :nutritionists
  devise_for :users
  root 'home#index'

  resources :food
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
=======
  resources :foods  
  get '/api-fetch' => 'foods#api_fetch', as: 'api_fetch'
>>>>>>> for api testing
end
