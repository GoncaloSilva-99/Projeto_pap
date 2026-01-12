class ClubLockerRoom < ApplicationRecord
  belongs_to :club_profile
  belongs_to :club_training_center, optional: :true
  belongs_to :sport
  has_one_attached :locker_room_picture
end
