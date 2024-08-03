# frozen_string_literal: true

class Engineer < ApplicationRecord
  validates :name, presence: true
end
