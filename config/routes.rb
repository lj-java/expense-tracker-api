ExpenseTrackerApi::Application.routes.draw do
  namespace :api do
    resources :expenses, only: [ :index, :create, :destroy ]
  end
end
