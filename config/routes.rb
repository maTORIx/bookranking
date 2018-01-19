Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :auth, except:[:index, :update, :edit, :show] do
  end

  resources :user, except:[:index, :show] do
  end
end
