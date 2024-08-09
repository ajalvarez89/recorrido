# frozen_string_literal: true

module V1
  class ServicesController < ApplicationController
    before_action :service, only: :show

    def index
      render json: Service.all
    end

    def show
      render json: @service
    end

    def create
      @service = Service.new
      service = Services::CreateService.new(service: @service, params: permitted_params)
      service.execute!

      render json: @service, status: :created
    end

    private

    def unprocessable_entity
      render json: { errors: api_messages(@service.errors.messages) }, status: __method__
    end

    def permitted_params
      @permitted_params ||= ServicePermittedParams.permitted_params_for(params)
    end

    def service
      @service = Service.find(params[:id])
    end
  end
end
