class ClubTeamTraining < ApplicationRecord
  belongs_to :club_locker_room, optional: true
  belongs_to :club_pitch
  belongs_to :club_team

  validates :pitch_zone, presence: true

end
