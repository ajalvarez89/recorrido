# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    resources :engineers, only: %i[index show create], param: :id
    resources :contracts, only: %i[index show create], param: :id
    resources :services, only: %i[index show create], param: :id
    resources :shifts, only: %i[index show update], param: :id
  end
end
