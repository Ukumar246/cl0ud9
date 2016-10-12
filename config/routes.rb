Rails.application.routes.draw do 
  get 'welcome/index'

  # RA: Added tournaments as a resource, this provides us with useful endpoints
  # that we'll probably use in the project (run: rails routes)
  resources :tournaments do
		resources :photos
		resources :sponsorships
  end

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
