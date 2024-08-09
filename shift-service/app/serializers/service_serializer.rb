# frozen_string_literal: true

class ServiceSerializer < ActiveModel::Serializer
  attribute :id
  attribute :name
  attribute :description
end
