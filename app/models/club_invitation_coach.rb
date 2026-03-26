class ClubInvitationCoach < ApplicationRecord
  belongs_to :club_profile
  belongs_to :coach_profile

  validates :status, inclusion: { in: %w[pending accepted rejected] }

  after_update :associate_coach_to_club, if: -> {accepted? and saved_change_to_status?}

    def pending?
      status == 'pending'
    end

    def accepted?
      status == 'accepted'
    end

    def rejected?
      status == 'rejected'
    end

    private

    def associate_coach_to_club
      coach_profile.update!(
        club_profile: club_profile
      )
    end
end
