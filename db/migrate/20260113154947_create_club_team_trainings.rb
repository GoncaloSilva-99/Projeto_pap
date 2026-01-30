class CreateClubTeamTrainings < ActiveRecord::Migration[8.0]
  def change
    create_table :club_team_trainings do |t|
      t.references :club_locker_room, null: false, foreign_key: true
      t.references :club_pitch, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :recurring
      t.integer :weekday
      t.references :club_team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
