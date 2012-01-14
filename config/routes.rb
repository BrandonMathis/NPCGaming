NPCGaming::Application.routes.draw do
  match 'posts/category/:category_name' => 'posts#category'
  match 'posts/archive' => 'posts#archive'

  match 'user/edit' => 'users#edit', :as => :edit_current_user
  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login

  resources :posts
  resources :sessions
  resources :users
  resources :categories

  root :to => 'posts#index'
end
