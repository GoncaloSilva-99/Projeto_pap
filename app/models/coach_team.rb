class CoachTeam < ApplicationRecord
  belongs_to :coach_profiles
  belongs_to :club_teams
end
