# frozen_string_literal: true

module Engineers
  class CreateService < BaseService
    def execute!
      assign_engineer_attributes
      engineer.save!
    end
  end
end
