class ChangeClubProfileAssociationToPlayerProfileToAllowNullInCoachProfile < ActiveRecord::Migration[8.0]
  def change
    change_column_null :coach_profiles, :club_profile_id, true
  end
end
