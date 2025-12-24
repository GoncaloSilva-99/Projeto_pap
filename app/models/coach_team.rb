class CoachTeam < ApplicationRecord
  belongs_to :coach_profile
  belongs_to :club_team

  def self.ransackable_attributes(auth_object = nil)
    ["id", "coach_profile_id", "club_team_id"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["coach_profile", "club_team"]
  end
end
