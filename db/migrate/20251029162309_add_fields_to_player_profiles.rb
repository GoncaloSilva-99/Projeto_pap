class AddFieldsToPlayerProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :player_profiles, :sport, :string
    add_column :player_profiles, :secondary_position, :string
    add_column :player_profiles, :dominant_foot_or_hand, :string 
  end
end
