class CreateClubPitches < ActiveRecord::Migration[8.0]
  def change
    create_table :club_pitches do |t|
      t.references :club_profiles, null: false, foreign_key: true
      t.references :club_training_centers, null: false, foreign_key: true
      t.references :sports, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
