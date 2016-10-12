Rails.application.routes.draw do 
  get 'player/profiles'
  get 'sessions/new'
  get 'welcome/index'

  # RA: Added tournaments as a resource, this provides us with useful endpoints
  # that we'll probably use in the project (run: rails routes)
  resources :tournaments do
		resources :photos
		resources :sponsorships
  end

  # LT: Added some aliases(?) for people actions and some for sessions (not yet implemented)
  # TODO: Must update autotesters to test these endpoints
  get    '/signup',  to: 'people#new',  :as => :person
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # LT: Added people as a resource. Not sure how many of these we'll use, but yea.
  resources :people
  
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
