# frozen_string_literal: true

module Contracts
  class CreateService < BaseService
    def execute!
      assign_contract_attributes
      contract.build_end_date
      contract.save!

      ContractCreatedEvent.new(contract).publish!

      true
    end
  end
end
