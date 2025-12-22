class PlayerTeam < ApplicationRecord
  belongs_to :player_profile
  belongs_to :club_team
end
