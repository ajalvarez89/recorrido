# frozen_string_literal: true

class Service < ApplicationRecord
  has_many :contracts, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
