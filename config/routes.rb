Rails.application.routes.draw do
  devise_scope :user do
    unauthenticated :user do
      root 'users/sessions#new', as: :unauthenticated_root
    end

    authenticated :user do
      root 'static_pages#home', as: :authenticated_root
    end
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :users, only: [ :index, :show ]
  resources :friend_requests
end
