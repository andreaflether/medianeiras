# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.date :scheduled_for
      t.time :starts_at
      t.time :ends_at
      t.references :location, foreign_key: true

      t.timestamps
    end
  end
end
