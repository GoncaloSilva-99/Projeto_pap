class ClubPitch < ApplicationRecord
  belongs_to :club_profile
  belongs_to :club_training_center, optional: :true
  belongs_to :sport
  has_one_attached :pitch_picture
end
