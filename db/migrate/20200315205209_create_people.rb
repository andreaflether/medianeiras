# frozen_string_literal: true

class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :name
      t.date :birthday
      t.string :address
      t.string :neighborhood
      t.string :religion
      t.string :rg
      t.date :start_date
      t.date :exit_date
      t.string :citizenship
      t.string :civil_status
      t.string :zip_code

      t.timestamps
    end
  end
end
