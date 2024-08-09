# frozen_string_literal: true

module V1
  class ShiftsController < ApplicationController
    has_scope :by_date
    has_scope :by_day_of_week
    has_scope :by_contract

    before_action :shift, only: %i[show update]

    def index
      render json: apply_scopes(Shift).all
    end

    def show
      render json: shift
    end

    def update
      service = Shifts::UpdateService.new(shift:, params: permitted_params)
      service.execute!

      render json: shift
    end

    private

    def unprocessable_entity
      render json: { errors: api_messages(@shift.errors.messages) }, status: __method__
    end

    def permitted_params
      @permitted_params ||= ShiftPermittedParams.permitted_params_for(params)
    end

    def shift
      @shift = Shift.find(params[:id])
    end
  end
end
