# frozen_string_literal: true

class CreateJoinTableActivityStudent < ActiveRecord::Migration[5.2]
  def change
    create_join_table :activities, :students do |t|
      # t.index [:activity_id, :student_id]
      # t.index [:student_id, :activity_id]
    end
  end
end
