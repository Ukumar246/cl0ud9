Rails.application.routes.draw do 
  get 'sponsors/new'
  post 'sponsors/create'

  get 'golf_courses/new'

  devise_for :people

  get '/players/:id' => 'players#show'#, constraints: { id: /^[1-9][0-9]*$/ }
  #get 'player/show'
  get 'players/list'
  get 'players/new'
  post 'players/create'

  get 'welcome/index'

  #Rabachi: for the static pages
  get "/misc_pages/:misc_page" => "misc_pages#show"

  # RA: Added tournaments as a resource, this provides us with useful endpoints
  # that we'll probably use in the project (run: rails routes)
  resources :tournaments do
		resources :photos
		resources :sponsorships
  end

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # saves a golf course after model validation
  post '/create_golf_course', to: 'golf_courses#create_golf_course'
end
