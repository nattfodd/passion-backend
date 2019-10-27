# frozen_string_literal: true

class CategoriesController < ApplicationController
  def index
    render json: categories
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

  def categories
    relation = Category.all
    relation = relation.where(vertical_id: vertical_id) if vertical_id
    relation
  end

  def vertical_id
    params[:vertical_id]
  end

  def category
    @category ||= Category.find(params.require(:id))
  end

  def model_params
    params.permit(:name, :vertical_id, :state)
  end
end
