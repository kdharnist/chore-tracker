Rails.application.routes.draw do
  
  devise_for :users
  root 'welcome#index'

  resources :chores
  resources :households

end
