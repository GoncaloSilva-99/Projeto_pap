class CreateClubTrainingCenters < ActiveRecord::Migration[8.0]
  def change
    create_table :club_training_centers do |t|
      t.references :club_profile, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
