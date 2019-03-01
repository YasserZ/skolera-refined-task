Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index]
      resources :courses do
        member do
          post 'add_student'
          delete 'remove_student'
          post 'assign_teacher'
          delete 'remove_teacher'
        end

      end
      resources :teachers
      resources :students

    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
