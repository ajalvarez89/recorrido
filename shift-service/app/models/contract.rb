# frozen_string_literal: true

class Contract < ApplicationRecord
  belongs_to :service
  has_many :shifts, dependent: :destroy
  has_many :engineer_shifts, through: :shifts

  validates :start_date, :end_date, presence: true

  validates :start_hour_weekday, :end_hour_weekday, :start_hour_weekend, :end_hour_weekend,
            numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 23 }
  validates :service_id, uniqueness: { scope: %i[start_date end_date] }

  validate :start_date_must_be_start_of_week, if: :start_date

  validates_with TimeRangeValidator

  def build_end_date
    return unless start_date

    self.end_date = start_date + 6.days
  end

  private

  def start_date_must_be_start_of_week
    return if start_date.beginning_of_week == start_date

    errors.add(:start_date, I18n.t('errors.messages.invalid_start_date', start_date:))
  end
end
