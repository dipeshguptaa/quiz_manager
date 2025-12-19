Rails.application.routes.draw do
  namespace :admin do
    resources :quizzes do
      resources :questions
    end
    resources :submissions, only: [:index, :show]
    root "dashboard#index"
  end

  resources :quizzes, only: [:index, :show]
  resources :submissions, only: [:create, :show]

  root "quizzes#index"
end
