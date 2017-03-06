Rails.application.routes.draw do
  post 'auth_user' => 'authentication#authenticate_user'

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :posts, only: %w(show create index)
      namespace :reports do
        post 'by_author' => 'by_author#index'
      end
      namespace :users do
        get 'avatar/show' => 'avatar#show'
        post 'avatar/create' => 'avatar#create', defaults: {format: :html}
      end
    end
  end
end
