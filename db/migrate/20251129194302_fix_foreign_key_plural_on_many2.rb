class FixForeignKeyPluralOnMany2 < ActiveRecord::Migration[8.0]
  def change

    rename_column :club_sports, :club_profiles_id, :club_profile_id if column_exists?(:club_sports, :club_profiles_id)
    rename_column :club_sports, :sports_id, :sport_id if column_exists?(:club_sports, :sports_id)

    rename_column :club_teams, :club_profiles_id, :club_profile_id if column_exists?(:club_teams, :club_profiles_id)
    rename_column :club_teams, :sports_id, :sport_id if column_exists?(:club_teams, :sports_id)


    rename_column :coach_teams, :coach_profiles_id, :coach_profile_id if column_exists?(:coach_teams, :coach_profiles_id)
    rename_column :coach_teams, :club_teams_id, :club_team_id if column_exists?(:coach_teams, :club_teams_id)

    rename_column :player_teams, :player_profiles_id, :player_profile_id if column_exists?(:player_teams, :player_profiles_id)
    rename_column :player_teams, :club_teams_id, :club_team_id if column_exists?(:player_teams, :club_teams_id)
  end
end
