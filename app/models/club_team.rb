class ClubTeam < ApplicationRecord
  belongs_to :club_profile
  belongs_to :sport
  has_many :coach_teams, dependent: :destroy
  has_many :player_teams, dependent: :destroy
end
