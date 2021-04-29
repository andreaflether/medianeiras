# frozen_string_literal: true

class CreateJoinTableActivityVolunteer < ActiveRecord::Migration[5.2]
  def change
    create_join_table :activities, :volunteers do |t|
      # t.index [:activity_id, :volunteer_id]
      # t.index [:volunteer_id, :activity_id]
    end
  end
end
