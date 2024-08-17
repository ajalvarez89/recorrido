# frozen_string_literal: true

class DistributeShiftsWorker
  include Sneakers::Worker

  QUEUE_NAME = 'shift-service.distribute-shifts'

  from_queue QUEUE_NAME,
    routing_key: ['shifts.updated'],
    arguments: { 'x-dead-letter-exchange': "#{ QUEUE_NAME }-retry" },
    timeout_job_after: 1.minute,
    retry_max_times: 4,
    retry_timeout: 15.minutes.in_milliseconds

  def work(params)
    payload = JSON.parse(params).deep_symbolize_keys

    Shifts::DistributeService.new(payload).execute!
    ack!
  end
end
