class CoachTeam < ApplicationRecord
  belongs_to :coach_profile
  belongs_to :club_team

end
