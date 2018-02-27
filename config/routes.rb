Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  get "/signin", to: "auth#new"
  get "/login" => redirect("/signin")
  get "/signup", to: "users#new"

  resources :auth, except:[:index, :update, :edit, :show] do
    post "/confirm", to: "users#confirm_email", on: :collection
  end

  resources :users, except:[:index] do
    resources :book_shelf, only: [:show, :create, :destroy], param: :book_id
    get "/confirm/:confirm_hash", to: "users#confirm"
  end

  resources :reviews, only: [:show, :edit, :update]

  resources :books, except: [:index]  do
    resources :reviews, only: [:index, :create, :new]
    resources :easy_reviews, only: [:create]
    resources :tags, only:[:create]
    resources :authors, only:[:create]
  end

  resources :rankings, only: [:index] do
    collection do
      resources :tags, only: [:index, :destroy]
      resources :authors, only: [:index, :destroy]
      resources :stars, only: [:index, :destroy]
    end
  end

  resources :requests, only: [:index, :show, :update, :destroy]
end
