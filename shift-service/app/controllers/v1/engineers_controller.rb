# frozen_string_literal: true

module V1
  class EngineersController < ApplicationController
    before_action :engineer, only: :show

    def index
      render json: Engineer.all
    end

    def show
      render json: @engineer
    end

    def create
      @engineer = Engineer.new
      service = Engineers::CreateService.new(engineer: @engineer, params: permitted_params)
      service.execute!

      render json: @engineer, status: :created
    end

    private

    def unprocessable_entity
      render json: { errors: api_messages(@engineer.errors.messages) }, status: __method__
    end

    def permitted_params
      @permitted_params ||= EngineerPermittedParams.permitted_params_for(params)
    end

    def engineer
      @engineer = Engineer.find(params[:id])
    end
  end
end
