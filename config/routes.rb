ImpressShareRails::Application.routes.draw do

  resources :slides do
    post :preview, on: :collection
  end


  root :to => 'slides#index'

  resources :users do
  end


  resources :sessions, only: [:new]do
  end
  resource :session, only: [:create, :destroy] do
  end

end
