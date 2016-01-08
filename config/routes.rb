Rails.application.routes.draw do
  
  devise_for :users
  root 'welcome#index'

  resources :chores do
  	member do
  		get 'complete'
  		get 'incomplete'
  	end
  end

  resources :households

  resources :households do
  	member do
    	get 'join'
    	get 'leave'
  	end
  end

end
