class AddLockerRoomTimesToTrainings < ActiveRecord::Migration[8.0]
  def change
    add_column :club_team_trainings, :locker_room_time_before, :integer, default: 0
    add_column :club_team_trainings, :locker_room_time_after, :integer, default: 0
    change_column_null :club_team_trainings, :club_locker_room_id, true
  end
end
