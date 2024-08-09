# frozen_string_literal: true

module Services
  class BaseService
    def initialize(service:, params:)
      @service = service
      @params = params
    end

    private

    attr_reader :service, :params

    def assign_service_attributes
      service.assign_attributes(params)
    end
  end
end
