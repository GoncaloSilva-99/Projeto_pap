class CreatePlayerTeams < ActiveRecord::Migration[8.0]
  def change
    create_table :player_teams do |t|
      t.references :player_profiles, null: false, foreign_key: true
      t.references :club_teams, null: false, foreign_key: true

      t.timestamps
    end
  end
end
