class PlayerTeam < ApplicationRecord
  belongs_to :player_profiles
  belongs_to :club_teams
end
