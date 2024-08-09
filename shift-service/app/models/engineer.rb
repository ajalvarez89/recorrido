# frozen_string_literal: true

class Engineer < ApplicationRecord
  has_many :engineer_shifts, dependent: :destroy
  has_many :shifts, through: :engineer_shifts

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
