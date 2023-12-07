Rails.application.routes.draw do
  root to: 'home#index'

  resources :student_distributions
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
  get 'new_import_student_distributions' => 'student_distributions#new_import'
  post 'new_import_student_distributions' => 'student_distributions#import'

  get 'home/index'
  get '/auth/:provider/callback', to: 'sessions#omniauth'
  get 'sessions/omniauth'
end