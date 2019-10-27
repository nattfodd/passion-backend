# frozen_string_literal: true

class ApplicationController < ActionController::API
  def render_validation_errors(entity)
    render json: entity.errors, status: :unprocessable_entity
  end
end
