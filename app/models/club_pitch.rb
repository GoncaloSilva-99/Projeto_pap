class ClubPitch < ApplicationRecord
  belongs_to :club_profile
  belongs_to :club_training_center, optional: :true
  belongs_to :sport
  has_one_attached :pitch_picture
  has_many :club_team_trainings, dependent: :destroy

  PITCH_TYPE = ["Campo de Futebol de 11", "Campo de Futebol de 9", "Campo de Futebol de 7", "Campo de Futebol de 5"]
  PITCH_ZONES_11 = ["Zona A (Campo Inteiro)", "Zona B (Meio Campo 1)", "Zona C (Meio Campo 2)", "Zona D (Quarto de Campo 1)", "Zona E (Quarto de Campo 2)", "Zona F (Quarto de Campo 3)", "Zona G (Quarto de Campo 4)"]
  PITCH_ZONES_OTHERS = ["Zona A (Campo Inteiro)", "Zona B (Meio Campo 1)", "Zona C (Meio Campo 2)"]

  def fut11?
    pitch_type == "Campo de Futebol de 11"
  end

  def fut9?
    pitch_type == "Campo de Futebol de 9"
  end

  def fut7?
    pitch_type == "Campo de Futebol de 7"
  end

  def fut5?
    pitch_type == "Campo de Futebol de 5"
  end

end
