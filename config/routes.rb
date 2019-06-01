Rails.application.routes.draw do
    resources :sessions, only: [:new, :create, :destroy]
    resources :users, only: [:new, :create, :show]
    
    resources :posts do
        collection do
            post :confirm
        end
    end
    root to: 'posts#index'
end
