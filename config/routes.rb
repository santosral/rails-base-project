Rails.application.routes.draw do
  devise_for :admins
  devise_for :nutritionists
  devise_for :users, path: 'devise'

  root 'home#index'
  get '/home/approve/:id' => 'home#approve', as: 'approve'

  resources :users
  get '/users/:user_id/foods/:id' => 'users#food', as: 'user_food'

  resources :nutritionists
  get '/nutritionists/:nutritionist_id/articles/:id' => 'nutritionists#article', as: 'nutritionist_article'

  resources :foods
  get '/nutritional' => 'foods#nutritional_info', as: 'nutrition'
  resources :comments, only: %i[create destroy]

  resources :articles
  resources :acomments, only: %i[create destroy]

  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  # mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :foods  
  get '/api-fetch' => 'foods#api_fetch', as: 'api_fetch'
end
