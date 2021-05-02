# frozen_string_literal: true

class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :name
      t.integer :status, default: 0
      t.text :description
      t.date :closure_date
      t.string :closure_reason
      t.integer :max_capacity
      t.time :starts_at
      t.time :ends_at
      t.string :display_image
      t.references :location, foreign_key: true

      t.timestamps
    end
  end
end
