Rails.application.routes.draw do
  root to: 'home#index'
  resources :criteria
  resources :roles
  resources :groups
  resources :students
  resources :units
  resources :people
  get 'new_import_people' => 'people#new_import'
  post 'new_import_people' => 'people#import'
  get 'new_import_students' => 'students#new_import'
  post 'new_import_students' => 'students#import'
  get 'new_import_groups' => 'groups#new_import'
  post 'new_import_groups' => 'groups#import'
  get 'new_import_criteria' => 'criteria#new_import'
  post 'new_import_criteria' => 'criteria#import'

  get "/auth/:provider/callback", to: "sessions#omniauth"
  get 'sessions/omniauth'
end