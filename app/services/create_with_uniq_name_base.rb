# frozen_string_literal: true

class CreateWithUniqNameBase
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    result = with_transaction_lock do
      break { errors: ["name #{name} is already taken"] } if name_taken?

      entity = model_class.create(params)
      break validation_errors(entity) unless entity.persisted?

      MessageBroker.new("#{entity} created").call
      entity
    end

    ServiceResponse.new(result)
  end

  private

  def with_transaction_lock
    model_class.transaction do
      model_class.with_advisory_lock(name, transaction: true)
      yield
    end
  end

  def validation_errors(entity)
    { errors: entity.errors.full_messages }
  end

  def name
    params.fetch(:name)
  end

  def name_taken?
    Vertical.find_by(name: name).present? || Category.find_by(name: name).present?
  end

  def model_class
    raise(NotImplementedError)
  end
end
