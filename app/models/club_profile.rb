class ClubProfile < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user
  has_many :board_profiles, dependent: :destroy
  has_one_attached :profile_picture
  has_one_attached :banner_picture
  has_one_attached :verification_document
  has_many :club_teams, dependent: :destroy
  has_many :club_sports, dependent: :destroy
  has_one :club_balance, dependent: :destroy
  has_many :club_expenses, dependent: :destroy
  has_many :club_incomes, dependent: :destroy

  REGEX_NUM_TELEMOVEL = /\A9\d{8}\z/
  MIN_DATE = 1.day.ago.to_date

  validates_presence_of :name, :foundation_date, :verification_document

  def has_football?
    club_sports.exists?(sport_id: 2)
  end

  def has_handball?
    club_sports.exists?(sport_id: 3)
  end

  def has_both_sports?
    has_football? and has_handball?
  end

  def has_no_sports?
    !has_football? and !has_handball?
  end

  def has_teams?
    club_teams.exists?
  end

  def has_football_teams?
    club_teams.exists?(sport_id: 2)
  end

  def has_handball_teams?
    club_teams.exists?(sport_id: 3)
  end

  def has_teams_in_both?
    has_handball_teams? and has_football_teams?
  end

end
