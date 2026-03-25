class ClubInvitationCoach < ApplicationRecord
  belongs_to :club_profile
  belongs_to :coach_profile
end
