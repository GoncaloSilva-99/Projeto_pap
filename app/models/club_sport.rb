class ClubSport < ApplicationRecord
  belongs_to :club_profiles
  belongs_to :sports
end
