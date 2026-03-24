class AddDefaultStatusToClubInvitationPlayers < ActiveRecord::Migration[8.0]
  def change
    change_column_default :club_invitation_players, :status, from: nil, to: "pending"
  end
end