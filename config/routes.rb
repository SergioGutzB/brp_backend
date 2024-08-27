Rails.application.routes.draw do
  # devise_for :users
  devise_for :users,
    controllers: {
      sessions: 'api/v1/sessions',
      registrations: 'api/v1/registrations'
    },
    defaults: { format: :json }
  
  namespace :api do
    namespace :v1 do
      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy'
      
      resources :users, only: [:index, :show, :create, :update, :destroy]
      resources :admin_profiles, only: [:index, :show, :create, :update, :destroy]
      resources :executive_profiles, only: [:index, :show, :create, :update, :destroy]
      resources :employee_profiles, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
