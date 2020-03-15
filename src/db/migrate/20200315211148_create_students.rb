class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :current_grade
      t.string :school

      t.timestamps
    end
  end
end
