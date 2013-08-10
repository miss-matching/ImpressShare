ImpressShareRails::Application.routes.draw do

  resources :slides do
    post :preview, on: :collection
    get :presentation, on: :member
  end

  match "/auth/:provider/callback" => "sessions#create"

  root :to => 'slides#index'

  resources :users do
    resources :slides, only:[:index] do
    end
  end

  resources :sessions, only: [:new]do
  end
  resource :session, only: [:create, :destroy] do
  end

end
