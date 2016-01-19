Rails.application.routes.draw do
  resources :photos
  root 'welcome#index'
end
