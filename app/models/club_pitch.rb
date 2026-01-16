class ClubPitch < ApplicationRecord
  belongs_to :club_profile
  belongs_to :club_training_center, optional: :true
  belongs_to :sport
  has_one_attached :pitch_picture

  PITCH_TYPE = ["Campo de Futebol de 11", "Campo de Futebol de 9", "Campo de Futebol de 7", "Campo de Futebol de 5"]
end
