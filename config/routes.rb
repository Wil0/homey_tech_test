# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'projects#index'

  resources :projects, only: %i[show index edit update] do
    resources :comments, only: %i[create show]
  end
end
