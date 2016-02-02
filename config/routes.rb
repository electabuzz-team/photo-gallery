Rails.application.routes.draw do
  resources :photos
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

	get 'search' => 'photos#search'
  post 'search_result' => 'photos#search_photo'
  post 'search_result_json' => 'photos#search_photo_json'
end
