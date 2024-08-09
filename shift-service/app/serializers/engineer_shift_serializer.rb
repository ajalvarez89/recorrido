# frozen_string_literal: true

class EngineerShiftSerializer < ActiveModel::Serializer
  attribute :id
  attribute :engineer_id
  attribute :status
  attribute :_destroy
end
