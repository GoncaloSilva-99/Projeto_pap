class CoachProfile < ApplicationRecord
  belongs_to :user
  has_many :coach_teams
  belongs_to :club_profile, optional: true
  has_one_attached :profile_picture
  has_one_attached :banner_picture
  accepts_nested_attributes_for :coach_teams

  SPORTS = ["football", "handball"]
  MIN_AGE = 16.years.ago.to_date
  REGEX_NUM_TELEMOVEL = /\A9\d{8}\z/
  TYPE = ["Treinador Principal", "Treinador Adjunto", "Preparador Físico", "Treinador de bolas paradas", "Treinador de Guarda Redes"]

  validates_presence_of :sport, inclusion: {in: SPORTS}
  validates_presence_of :coach_type, inclusion: {in: TYPE}
  validates_presence_of :name, :birth_date

  include PgSearch::Model
  
  pg_search_scope :search_by_name, against: :name, using: { tsearch: {prefix: true} }

end
