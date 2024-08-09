# frozen_string_literal: true

class CreateContracts < ActiveRecord::Migration[7.1]
  def change
    create_table :contracts, id: :uuid do |t|
      t.references :service, type: :uuid, index: true, foreign_key: true
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.integer :start_hour_weekday, null: false
      t.integer :end_hour_weekday, null: false
      t.integer :start_hour_weekend, null: false
      t.integer :end_hour_weekend, null: false

      t.timestamps
    end
  end
end
