# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    resources :engineers, only: %i[index show create update], param: :id
  end
end
