class CreateVolunteers < ActiveRecord::Migration[5.2]
  def change
    create_table :volunteers do |t|
      t.string :email
      t.string :speciality
      t.string :cpf

      t.timestamps
    end
  end
end
