class CreateClubLockerRooms < ActiveRecord::Migration[8.0]
  def change
    create_table :club_locker_rooms do |t|
      t.references :club_profile, null: false, foreign_key: true
      t.references :club_training_center, null: false, foreign_key: true
      t.references :sport, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
