# frozen_string_literal: true

module Contracts
  class BaseService
    def initialize(contract:, params:)
      @contract = contract
      @params = params
    end

    private

    attr_reader :contract, :params

    def assign_contract_attributes
      contract.assign_attributes(params)
    end
  end
end
