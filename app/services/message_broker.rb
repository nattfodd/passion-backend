# frozen_string_literal: true

class MessageBroker
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def call
    # Can be either SQS, email, or whatever
    Rails.logger.info "<#{message}> sent."
  end
end
