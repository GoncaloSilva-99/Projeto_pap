class PlayerProfile < ApplicationRecord
  belongs_to :user
  belongs_to :club_profile, optional: true
  has_one_attached :profile_picture
  has_one_attached :banner
  
  
  SPORTS = ["Futebol", "Andebol"]
  POSITIONS = {
    "Futebol" => ["Guarda-Redes", "Lateral Direito", "Lateral Esquerdo", "Central", "Médio Centro", "Médio Ofensivo", "Médio Defensivo", "Extremo Direito", "Extremo Esquerdo", "Ponta de lança"],
    "Andebol" => ["Guarda-Redes", "Central", "Lateral Esquerdo", "Lateral Direito", "Ponta Esquerda", "Pivô", "Ponta Direita"]
  }
  DOMINANT = ["Direito", "Esquerdo"]
  ALL_POSITIONS = ["Guarda-Redes", "Lateral Direito", "Lateral Esquerdo", "Central", "Médio Centro", "Médio Ofensivo", "Médio Defensivo", "Extremo Direito", "Extremo Esquerdo", "Ponta de lança", "Ponta Esquerda", "Pivô", "Ponta Direita"]

  REGEX_NUM_TELEMOVEL = /\A9\d{8}\z/

  MIN_AGE = 4.years.ago.to_date

  validates_presence_of :position, inclusion: {in: ALL_POSITIONS}
  validates_presence_of :sport, inclusion: {in: SPORTS}
  validates_presence_of :dominant_foot_or_hand, inclusion: {in: DOMINANT}
  validates_presence_of :name, :birth_date, :contact

end
