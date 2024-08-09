# frozen_string_literal: true

module V1
  class ContractsController < ApplicationController
    before_action :contract, only: :show

    def index
      render json: Contract.all
    end

    def show
      render json: @contract
    end

    def create
      @contract = Contract.new
      service = Contracts::CreateService.new(contract: @contract, params: permitted_params)
      service.execute!

      render json: @contract, status: :created
    end

    private

    def unprocessable_entity
      render json: { errors: api_messages(@contract.errors.messages) }, status: __method__
    end

    def permitted_params
      @permitted_params ||= ContractPermittedParams.permitted_params_for(params)
    end

    def contract
      @contract = Contract.find(params[:id])
    end
  end
end
