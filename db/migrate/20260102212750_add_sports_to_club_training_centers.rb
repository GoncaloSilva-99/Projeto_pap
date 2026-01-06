class AddSportsToClubTrainingCenters < ActiveRecord::Migration[8.0]
  def change
    add_reference :club_training_centers, :sport, null: false, foreign_key: true
  end
end
