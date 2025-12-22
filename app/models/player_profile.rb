class PlayerProfile < ApplicationRecord
  belongs_to :user
  belongs_to :club_profile, optional: true
  has_one_attached :profile_picture
  has_one_attached :banner_picture
  has_many :player_teams, dependent: :destroy
  accepts_nested_attributes_for :player_teams
  
  
  
  SPORTS = ["football", "handball"]
  POSITIONS = {
    "football" => ["Guarda-Redes", "Lateral Direito", "Lateral Esquerdo", "Central", "Médio Centro", "Médio Ofensivo", "Médio Defensivo", "Extremo Direito", "Extremo Esquerdo", "Ponta de lança"],
    "handball" => ["Guarda-Redes", "Central", "Lateral Esquerdo", "Lateral Direito", "Ponta Esquerda", "Pivô", "Ponta Direita"]
  }
  DOMINANT = ["Direito", "Esquerdo"]
  ALL_POSITIONS = ["Guarda-Redes", "Lateral Direito", "Lateral Esquerdo", "Central", "Médio Centro", "Médio Ofensivo", "Médio Defensivo", "Extremo Direito", "Extremo Esquerdo", "Ponta de lança", "Ponta Esquerda", "Pivô", "Ponta Direita"]

  REGEX_NUM_TELEMOVEL = /\A9\d{8}\z/

  MIN_AGE = 4.years.ago.to_date

  validates_presence_of :position, inclusion: {in: ALL_POSITIONS}
  validates_presence_of :sport, inclusion: {in: SPORTS}
  validates_presence_of :dominant_foot_or_hand, inclusion: {in: DOMINANT}
  validates_presence_of :name, :birth_date

end
