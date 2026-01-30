class CreateClubTeams < ActiveRecord::Migration[8.0]
  def change
    create_table :club_teams do |t|
      t.references :club_profiles, null: false, foreign_key: true
      t.string :name
      t.references :sports, null: false, foreign_key: true

      t.timestamps
    end
  end
end
