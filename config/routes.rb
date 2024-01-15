Rails.application.routes.draw do
  root to: 'home#index'

  resources :student_teachers
  resources :teacher_distributions
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
  get 'new_import_teacher_distributions' => 'teacher_distributions#new_import'
  post 'new_import_teacher_distributions' => 'teacher_distributions#import'
  get 'new_import_student_teachers' => 'student_teachers#new_import'
  post 'new_import_student_teachers' => 'student_teachers#import'

  get 'home/index'
  get '/auth/google_oauth2'
  get '/auth/:provider/callback', to: 'sessions#create'
  get "/auth/exit", to: 'sessions#destroy'
  get 'sessions/create'
  get 'create_survey', to: 'student_teachers#create_survey'
end