class CreateSuggestions < ActiveRecord::Migration[5.2]
  def change
    create_table :suggestions do |t|
      t.text :parents
      t.text :children
      t.text :comments

      t.timestamps
    end
  end
end
