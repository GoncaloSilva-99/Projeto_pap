class PlayerTeam < ApplicationRecord
  belongs_to :player_profile
  belongs_to :club_team

  def self.ransackable_attributes(auth_object = nil)
    ["id", "player_profile_id", "club_team_id"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["player_profile", "club_team"]
  end
end
