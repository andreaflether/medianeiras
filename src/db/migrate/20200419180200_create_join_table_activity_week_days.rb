class CreateJoinTableActivityWeekDays < ActiveRecord::Migration[5.2]
  def change
    create_join_table :activities, :week_days do |t|
      # t.index [:activity_id, :week_day_id]
      # t.index [:week_day_id, :activity_id]
    end
  end
end
