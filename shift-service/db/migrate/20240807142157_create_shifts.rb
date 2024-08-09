# frozen_string_literal: true

class CreateShifts < ActiveRecord::Migration[7.1]
  def change
    create_table :shifts, id: :uuid do |t|
      t.references :contract, type: :uuid, index: true, foreign_key: true
      t.date :date, null: false
      t.string :day_of_week, null: false
      t.string :start_hour, null: false
      t.string :end_hour, null: false

      t.timestamps
    end
  end
end
