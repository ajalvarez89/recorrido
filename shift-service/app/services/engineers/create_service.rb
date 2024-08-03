# frozen_string_literal: true

module Engineers
  class CreateService < BaseService
    def initialize(engineer:, params:)
      super(engineer: engineer, params: params)
    end

    def execute!
      assign_engineer_attributes
      engineer.save!
    end
  end
end
