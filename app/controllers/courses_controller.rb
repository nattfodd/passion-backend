# frozen_string_literal: true

class CoursesController < ApplicationController
  def index
    render json: courses
  end

  def create
    course = Course::Create.new(course_params).call
    return render(json: course.response) if course.success?

    render_validation_errors(course)
  end

  def update
    return render(json: course) if course.update(course_params)

    render_validation_errors(course)
  end

  def destroy
    course.destroy!
    render :ok
  end

  private

  def courses
    relation = Course.all
    relation = relation.where(category_id: category_id) if category_id
    relation
  end

  def category_id
    params[:category_id]
  end

  def course
    @course ||= Course.find(params.require(:id))
  end

  def course_params
    params.permit(:name, :author, :category_id, :active)
  end
end
