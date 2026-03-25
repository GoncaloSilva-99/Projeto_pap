class CreateClubInvitationPlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :club_invitation_players do |t|
      t.references :club_profile, null: false, foreign_key: true
      t.references :player_profile, null: false, foreign_key: true
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
