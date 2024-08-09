# frozen_string_literal: true

class EngineerShift < ApplicationRecord
  belongs_to :shift
  belongs_to :engineer

  # status options:
  #
  # scheduled - set scheduled status on engineer shift.
  # confirmed - set confirmed status on engineer shift.
  enum status: %i[scheduled confirmed]

  validates :engineer, uniqueness: { scope: :shift_id }
  validate :only_one_confirmed_per_shift, if: :confirmed?

  accepts_nested_attributes_for :engineer, allow_destroy: true

  private

  def only_one_confirmed_per_shift
    return if scheduled?

    return unless shift&.engineer_shifts&.confirmed&.exists?

    errors.add(:status, I18n.t('errors.messages.only_one_confirmed_per_shift'))
  end
end
