# frozen_string_literal: true

class ContractPermittedParams
  PERMITTED_PARAMS = %i[
    start_date
    end_date
    start_hour_weekday
    end_hour_weekday
    start_hour_weekend
    end_hour_weekend
    service_id
  ].freeze

  class << self
    def permitted_params_for(params)
      permitted_attributes = PERMITTED_PARAMS.dup
      params.permit(permitted_attributes).to_h
    end
  end
end
