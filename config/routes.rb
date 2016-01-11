Rails.application.routes.draw do
  
  devise_for :users
  root 'welcome#index'

  # Helper routes for marking chores complete or incomplete

  resources :chores do
  	member do
  		get 'complete'
  		get 'incomplete'
  	end
  end

  resources :households

  # Helper routes for a user joining or leaving a household

  resources :households do
  	member do
    	get 'join'
    	get 'leave'
  	end
  end

end
