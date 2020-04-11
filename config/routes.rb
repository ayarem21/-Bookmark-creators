Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'posts#index'

  scope :admin do
    resources :categories, controller: 'backoffice/categories', as: 'admin_categories'
  end
end
