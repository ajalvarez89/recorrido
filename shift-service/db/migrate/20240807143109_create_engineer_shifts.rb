# frozen_string_literal: true

class CreateEngineerShifts < ActiveRecord::Migration[7.1]
  def change
    create_table :engineer_shifts, id: :uuid do |t|
      t.references :shift, type: :uuid, index: true, foreign_key: true
      t.references :engineer, type: :uuid, index: true, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
