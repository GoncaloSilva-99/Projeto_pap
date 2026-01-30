class ChangeTrainingCenterAssociationToClubPitchesToAllowNull < ActiveRecord::Migration[8.0]
  def change
    change_column_null :club_pitches, :club_training_center_id, true
  end
end
