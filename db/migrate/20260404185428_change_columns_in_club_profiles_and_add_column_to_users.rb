class ChangeColumnsInClubProfilesAndAddColumnToUsers < ActiveRecord::Migration[8.0]
  def change
    change_column :club_profiles, :status, :string, default: "pending"
    rename_column :club_profiles, :approved_by, :decided_by
    add_column :users, :banned, :boolean, default: false
  end
end
