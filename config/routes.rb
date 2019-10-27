# frozen_string_literal: true

Rails.application.routes.draw do
  resources :categories
  resources :courses
  resources :verticals
end
