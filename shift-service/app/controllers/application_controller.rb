# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
  rescue_from ActionController::ParameterMissing, with: :unprocessable_entity

  private

  def unprocessable_entity
    render :nothing, status: __method__
  end

  def not_found
    render :nothing, status: __method__
  end
end
