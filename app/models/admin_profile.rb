class AdminProfile < ApplicationRecord
  belongs_to :user, dependent: :destroy
  accepts_nested_attributes_for :user
  has_one_attached :profile_picture
  has_one_attached :banner_picture

  validates_presence_of :name

  ROLE = ["Admin Regular", "Super Admin"]

  def regular?
    role == 'Admin Regular'
  end

  def super?
    role == 'Super Admin'
  end
end
