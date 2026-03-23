class ClubMaterial < ApplicationRecord
  belongs_to :club_profile
  has_one_attached :image

  include PgSearch::Model
  
  pg_search_scope :search_by_name, against: :name, using: { tsearch: {prefix: true} }
  
end
