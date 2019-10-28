# frozen_string_literal: true

class VerticalsController < ApplicationController
  def index
    render json: Vertical.all
  end

  def create
    vertical = Vertical::Create.new(model_params).call
    return render(json: vertical.response) if vertical.success?

    render_validation_errors(vertical)
  end

  def update
    return render(json: vertical) if vertical.update(model_params)

    render_validation_errors(vertical)
  end

  def destroy
    vertical.destroy!
    render :ok
  end

  private

  def vertical
    @vertical ||= Vertical.find(params.require(:id))
  end

  def model_params
    params.permit(:name)
  end
end
