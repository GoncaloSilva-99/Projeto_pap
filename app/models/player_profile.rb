class PlayerProfile < ApplicationRecord
  belongs_to :user
  belongs_to :club_profile, optional: true
  validates :name, presence: true
end
