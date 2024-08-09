# frozen_string_literal: true

require 'sneakers'
require 'sneakers/handlers/maxretry'

Sneakers.configure(
  amqp: ENV.fetch('RABBITMQ_URL', nil),
  vhost: '/',
  exchange: 'shift-service',
  exchange_type: :topic,
  exchange_options: {
    type: 'topic',
    durable: true
  },
  log: 'log/sneakers.log',
  share_threads: true,
  heartbeat: 2,
  retry_max_times: 5,
  timeout_job_after: 5,
  handler: Sneakers::Handlers::Maxretry,
  hooks: {
    before_fork: lambda do
      ActiveRecord::Base.connection.disconnect! if defined?(ActiveRecord::Base)
    end,
    after_fork: lambda do
      ActiveRecord::Base.establish_connection if defined?(ActiveRecord::Base)
    end
  }
)
