Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  get 'movies/:id/this_director' => 'movies#this_director', :as => :this_director
end
