class BoardProfile < ApplicationRecord
  belongs_to :user
  belongs_to :club_profile
  has_one_attached :profile_picture
  has_one_attached :banner_picture

  REGEX_NUM_TELEMOVEL = /\A9\d{8}\z/
  MIN_AGE = 16.years.ago.to_date

  validates_presence_of :name, :birth_date
end
