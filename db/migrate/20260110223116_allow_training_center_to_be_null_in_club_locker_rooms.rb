class AllowTrainingCenterToBeNullInClubLockerRooms < ActiveRecord::Migration[8.0]
  def change
    change_column_null :club_locker_rooms, :club_training_center_id, true
  end
end
