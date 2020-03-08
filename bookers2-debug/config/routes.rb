Rails.application.routes.draw do
  devise_for :users
  root :to=>'home#top'
  get 'home/about' => 'home#about'

  get 'users/:id/follows' => 'relationships#show',as: 'follows'
  get 'users/:id/followers' => 'relationships#index',as: 'followers'
  resources :relationships
  resources :users do
    resource :relationships, only: [:create,:destroy]
    get :search, on: :collection
  end
  resources :books do
      resource :favorites, only: [:create, :destroy,]
      resource :books, only: [:create, :destroy]
  	  resources :book_comments
  end
end
