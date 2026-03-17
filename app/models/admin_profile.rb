class AdminProfile < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
