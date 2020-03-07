class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.string :location
      t.string :days
      t.string :time_schedule
      t.integer :max_capacity

      t.timestamps
    end
  end
end
