class ClubInvitationPlayer < ApplicationRecord
  belongs_to :club_profile
  belongs_to :player_profile

  validates :status, inclusion: { in: %w[pending accepted rejected] }

  after_update :associate_player_to_club, if: -> { accepted? && saved_change_to_status? }

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

  def associate_player_to_club
    player_profile.update!(
      club_profile: club_profile
    )
  end

  

end
  