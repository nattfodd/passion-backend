# frozen_string_literal: true

class CategoriesController < ApplicationController
  def index
    render json: Category.all
  end

  def create
    category = Category::Create.new(model_params).call
    return render(json: category.response) if category.success?

    render_validation_errors(category)
  end

  def update
    return render(json: category) if category.update(model_params)

    render_validation_errors(category)
  end

  def destroy
    category.destroy!
    render :ok
  end

  private

  def category
    @category ||= Category.find(params.require(:id))
  end

  def model_params
    params.permit(:name, :vertical_id, :state)
  end
end
