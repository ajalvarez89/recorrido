# frozen_string_literal: true

class BaseEvent
  EXCHANGE = 'shift-service'

  def initialize(object)
    @object = object.to_json
  end

  def publish!
    exchange = channel.topic(EXCHANGE, durable: true)
    exchange.publish(object, routing_key: self.class::ROUTING_KEY)
  end

  private

  attr_reader :object

  def channel
    @channel ||= connection.create_channel
  end

  def connection
    @connection ||= Bunny.new(ENV.fetch('RABBITMQ_URL', nil)).tap(&:start)
  end
end
