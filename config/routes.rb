Rails.application.routes.draw do
  get 'organizer/new'
  post 'organizer/create'
  delete 'organizer/:id/' => 'organizer#destroy' 

  resources :check_in
  post 'check_in/submit'

  get 'sponsors/new'
  #post 'charges/create'
  post 'sponsors/create'

  #for searching for golf courses
  get 'tournaments/update_courses' => 'tournaments#update_courses'
  get 'tournaments/update_hosts' => 'tournaments#update_hosts'
  get 'tournaments/:id/refund' => 'tournaments#refund'
  get 'tournaments/:id/resend_confirmation' => 'tournaments#resend_confirmation'

  devise_for :people

  get '/people/:id' => 'people#show'#, constraints: { id: /^[1-9][0-9]*$/ }
  get 'people/list'
  get 'player/show'
  get 'people/new'
  post 'people/create'


  get 'welcome/index'

  #Rabachi: for the static pages
  get "/misc_pages/:misc_page" => "misc_pages#show"

  get 'tournaments/:id/organize' => "tournaments#organize"
  
  #for private tournaments
  controller :tournaments do
    get 'tournaments/:id/private/:key'     => :private_url
  end

  # RA: Added tournaments as a resource, this provides us with useful endpoints
  # that we'll probably use in the project (run: rails routes)
  resources :tournaments do
		resources :photos
		resources :sponsorships
  end

  resources :golf_courses
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Mailer Stuff
  get 'contact', to: 'messages#new', as: 'contact'
  post 'contact', to: 'messages#create'
  
  #payments
  resources :charges


  # saves a golf course after model validation
  # post '/create_golf_course', to: 'golf_courses#create_golf_course'
end
