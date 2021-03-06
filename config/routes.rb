Rails.application.routes.draw do
  root to: redirect('/rooms')

  resources :rooms do
    resources :joins
    resources :actions, only: :create
    resources :games
  end

  mount ActionCable.server => '/cable'

  resource :debug, only: :show do
    post :load_fixture
  end if Rails.env.development?

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
