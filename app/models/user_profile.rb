class UserProfile < ApplicationRecord
  belongs_to :user
  has_one_attached :profile_picture
  has_one_attached :banner

  validates_presence_of :name

end
