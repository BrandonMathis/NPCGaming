NPCGaming::Application.routes.draw do

  match 'user/edit' => 'users#edit', :as => :edit_current_user
  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login
  match 'post/archive' => 'content/posts#archive', :via => :get
  match 'post/unpublished' => 'content/posts#unpublished', :via => :get
  match 'about_us' => 'content/page#about_us'

  namespace :content do
    resources :posts
  end
  resources :sessions
  resources :users
  resources :categories

  root :to => 'content/posts#index'
end
