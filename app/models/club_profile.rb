class ClubProfile < ApplicationRecord
  belongs_to :user
  has_one_attached :profile_picture
  has_one_attached :banner
  has_one_attached :verification_document

  REGEX_NUM_TELEMOVEL = /\A9\d{8}\z/

  validates_presence_of :name, :foundation_date
end
