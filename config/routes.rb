Rails.application.routes.draw do
  root 'welcome#index'

	get 'search' => 'photos#search'
	post 'search_result' => 'photos#search_photo'
  post 'search_result_json' => 'photos#search_photo_json'

  devise_for :users

  resources :photos
end
