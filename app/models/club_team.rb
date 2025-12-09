class ClubTeam < ApplicationRecord
  belongs_to :club_profile
  belongs_to :sport
  has_many :coach_teams
end
