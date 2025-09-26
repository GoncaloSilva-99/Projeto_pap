class BoardProfile < ApplicationRecord
  belongs_to :user
  belongs_to :club_profile
end
