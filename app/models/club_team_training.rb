class ClubTeamTraining < ApplicationRecord
  belongs_to :club_locker_room
  belongs_to :club_pitch
  belongs_to :club_team
end
