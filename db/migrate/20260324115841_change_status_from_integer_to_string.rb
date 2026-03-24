class ChangeStatusFromIntegerToString < ActiveRecord::Migration[8.0]
  def change
    change_column :club_invitation_players, :status, :string
  end
end
