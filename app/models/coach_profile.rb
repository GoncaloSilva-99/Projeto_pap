class CoachProfile < ApplicationRecord
  belongs_to :user
  belongs_to :club_profile

  SPORTS = ["Futebol", "Andebol"]
  MIN_AGE = 16.years.ago.to_date
end
