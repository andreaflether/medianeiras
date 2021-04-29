# frozen_string_literal: true

class CreatePromulherForms < ActiveRecord::Migration[5.2]
  def change
    create_table :promulher_forms do |t|
      t.integer :family_size
      t.integer :f_children
      t.integer :m_children
      t.string :works

      t.timestamps
    end
  end
end
