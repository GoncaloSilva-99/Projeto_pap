class CoachProfile < ApplicationRecord
  belongs_to :user
  belongs_to :club_profile, optional: true
  has_one_attached :profile_picture

  SPORTS = ["Futebol", "Andebol"]
  MIN_AGE = 16.years.ago.to_date
  REGEX_NUM_TELEMOVEL = /\A9\d{8}\z/
  TYPE = ["Treinador Principal", "Treinador Adjunto", "Preparador Físico", "Treinador de bolas paradas", "Treinador de Guarda Redes"]

  validates_presence_of :sport, inclusion: {in: SPORTS}
  validates_presence_of :coach_type, inclusion: {in: TYPE}
  validates_presence_of :name, :birth_date

end
