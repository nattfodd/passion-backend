# frozen_string_literal: true

class ServiceResponse
  attr_reader :response

  def initialize(response)
    @response = response
  end

  def failure?
    response.respond_to?(:[]) && response[:errors].present?
  end

  def success?
    !failure?
  end

  def errors
    response[:errors] if failure?
  end
end
