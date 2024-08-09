# frozen_string_literal: true

class ContractCreatedEvent
  ROUTING_KEY = 'contract.created'
  EXCHANGE = 'shift-service'

  def initialize(contract)
    @contract = contract.to_json
  end

  def publish!
    exchange = channel.topic(EXCHANGE, durable: true)
    exchange.publish(contract, routing_key: ROUTING_KEY)
  end

  private

  attr_reader :contract

  def channel
    @channel ||= connection.create_channel
  end

  def connection
    @connection ||= Bunny.new(ENV.fetch('RABBITMQ_URL', nil)).tap(&:start)
  end
end
