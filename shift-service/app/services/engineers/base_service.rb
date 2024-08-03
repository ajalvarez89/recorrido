# frozen_string_literal: true

module Engineers
  class BaseService
    def initialize(engineer:, params:)
      @engineer = engineer
      @params = params
    end

    private

    attr_reader :engineer, :params

    def assign_engineer_attributes
      engineer.assign_attributes(params)
    end
  end
end
