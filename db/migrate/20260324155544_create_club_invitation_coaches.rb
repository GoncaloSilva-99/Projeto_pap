class CreateClubInvitationCoaches < ActiveRecord::Migration[8.0]
  def change
    create_table :club_invitation_coaches do |t|
      t.references :club_profile, null: false, foreign_key: true
      t.references :coach_profile, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
