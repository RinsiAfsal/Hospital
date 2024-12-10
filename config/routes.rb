Rails.application.routes.draw do
  devise_for :users

  # Root path for visitors (unauthenticated users)
  root to: "home#index"

  # Define routes for patients under receptionist and doctor namespaces
  namespace :receptionist do
    resources :patients, only: [:index, :new, :create, :edit, :update, :destroy, :show]
  end

  namespace :doctor do
    resources :patients, only: [:index]
    get "patients/graph", to: "patients#graph"
  end
end
