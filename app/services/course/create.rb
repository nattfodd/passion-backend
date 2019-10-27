# frozen_string_literal: true

class Course::Create
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    course = Course.create(params)
    if course.persisted?
      MessageBroker.new("#{course} created").call
      return ServiceResponse.new(course)
    end

    ServiceResponse.new(errors: course.errors.full_messages)
  end
end
