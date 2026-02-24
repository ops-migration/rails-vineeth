Rails.application.routes.draw do
  # UI routes
  root "tasks#index"
  resources :tasks

  # API routes
  namespace :api do
    namespace :v1 do
      resources :tasks, only: [:index, :show, :create, :update, :destroy]
    end
  end

  # Health check
  get "/up" => "rails/health#show", as: :rails_health_check
end
