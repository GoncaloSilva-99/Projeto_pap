class PlayerProfile < ApplicationRecord
  belongs_to :user
  belongs_to :club_profile, optional: true
  validates :name, presence: true

  validates :role, presence: true, inclusion: {in: ["Futebol", "Andebol"]}
  validates :dominant_foot_or_hand, inclusion: {in: ["Direito", "Esquerdo"]}
end
