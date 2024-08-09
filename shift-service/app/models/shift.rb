# frozen_string_literal: true

class Shift < ApplicationRecord
  belongs_to :contract
  has_many :engineer_shifts, dependent: :destroy
  has_many :engineers, through: :engineer_shifts

  validates :date,
            :day_of_week,
            :start_hour,
            :end_hour,
            presence: true

  scope :by_date, ->(date) { where(date:) }
  scope :by_contract, ->(contract_id) { where(contract_id:) }
  scope :by_day_of_week, ->(day_of_week) { where(day_of_week:) }

  accepts_nested_attributes_for :engineer_shifts, allow_destroy: true
end
