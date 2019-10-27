# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  use_doorkeeper do
    skip_controllers :authorizations, :applications,
                     :authorized_applications
  end

  resources :categories
  resources :courses
  resources :verticals
end
