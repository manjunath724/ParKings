Rails.application.routes.draw do
  resources :buildings
  resources :cars
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords' }

  authenticated :user, ->(u) { u.admin? } do
    root "buildings#index"
  end
  root 'cars#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
