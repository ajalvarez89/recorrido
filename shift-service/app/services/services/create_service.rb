# frozen_string_literal: true

module Services
  class CreateService < BaseService
    def execute!
      assign_service_attributes
      service.save!
    end
  end
end
