class ClubTrainingCenter < ApplicationRecord
  belongs_to :club_profile
  belongs_to :sport
  has_one_attached :ct_picture
end
