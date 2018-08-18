Rails.application.routes.draw do
  resources :buildings, except: :destroy

  resources :cars, except: :destroy do
    post :park, on: :member
  end

  resources :parking_requests, except: [:new, :create, :show] do
    member do
      post :automate
      post :release
      post :discharge
    end
  end

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords' }

  root 'parking_requests#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
