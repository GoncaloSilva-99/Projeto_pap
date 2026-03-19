class ClubMaterial < ApplicationRecord
  belongs_to :club_profile
  has_one_attached :image
  
end
