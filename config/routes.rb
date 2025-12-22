Rails.application.routes.draw do
  namespace :admin do
    resources :quizzes do
      resources :questions
    end
    resources :submissions, only: [:index, :show]
    root "dashboard#index"
  end

  resources :quizzes, only: [:show]
  resources :submissions, only: [:create, :show]

  get '/quizzes', to: redirect('/', status: 301)
  root "quizzes#index"
end
