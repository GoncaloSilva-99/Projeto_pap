class AddPitchTypeToClubPitchesAndPitchZoneToTraining < ActiveRecord::Migration[8.0]
  def change
    add_column :club_pitches, :pitch_type, :string
    add_column :club_team_trainings, :pitch_zone, :string
  end
end
