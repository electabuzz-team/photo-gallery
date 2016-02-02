Rails.application.routes.draw do
  root 'welcome#index'

	get 'search' => 'photos#search'
	post 'search_result' => 'photos#search_photo'

  devise_for :users

  resources :photos
end
