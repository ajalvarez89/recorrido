# frozen_string_literal: true

class CreateShiftsWorker
  include Sneakers::Worker

  QUEUE_NAME = 'shift-service.create-shifts'

  from_queue QUEUE_NAME,
    routing_key: ['contract.created'],
    arguments: { 'x-dead-letter-exchange': "#{ QUEUE_NAME }-retry" },
    timeout_job_after: 1.minute,
    retry_max_times: 4,
    retry_timeout: 15.minutes.in_milliseconds

  def work(params)
    payload = JSON.parse(params).deep_symbolize_keys

    Shifts::CreateService.new(payload).execute!
    ack!
  rescue StandardError
    reject!
  end
end
