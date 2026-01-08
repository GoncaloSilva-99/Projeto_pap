class FixPluralOnClubPitches < ActiveRecord::Migration[8.0]
  def change
    rename_column :club_pitches, :club_profiles_id, :club_profile_id if column_exists?(:club_pitches, :club_profiles_id)
    rename_column :club_pitches, :sports_id, :sport_id if column_exists?(:club_pitches, :sports_id)
    rename_column :club_pitches, :club_training_centers_id, :club_training_center_id if column_exists?(:club_pitches, :club_training_centers_id)
  end
end
