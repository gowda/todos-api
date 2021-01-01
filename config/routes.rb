# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api do
    resources :todos, only: %i[index create update destroy]
  end
end
