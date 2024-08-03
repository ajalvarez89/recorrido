# frozen_string_literal: true

class CreateEngineers < ActiveRecord::Migration[7.1]
  def change
    create_table :engineers, id: :uuid do |t|
      t.string :name
      t.string :color

      t.timestamps
    end
  end
end
