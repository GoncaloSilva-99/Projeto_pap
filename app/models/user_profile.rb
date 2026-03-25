class UserProfile < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_one_attached :profile_picture
  has_one_attached :banner
  accepts_nested_attributes_for :user

  validates_presence_of :name

end
