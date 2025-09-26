class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :role, presence: true, inclusion: {in: ["User", "Player", "Coach", "Club", "Board", "Admin"]}

  has_one :user_profile, dependent: :destroy
  accepts_nested_attributes_for :user_profile

  has_one :player_profile, dependent: :destroy
  accepts_nested_attributes_for :player_profile

  has_one :coach_profile, dependent: :destroy
  accepts_nested_attributes_for :coach_profile

  has_one :club_profile, dependent: :destroy
  accepts_nested_attributes_for :club_profile

  has_one :board_profile, dependent: :destroy
  accepts_nested_attributes_for :board_profile

  has_one :admin_profile, dependent: :destroy
  accepts_nested_attributes_for :admin_profile

  def user?
    role == "User"
  end

  def player?
    role == "Player"
  end

  def coach?
    role == "Coach"
  end

  def club?
    role == "Club"
  end

  def board?
    role == "Board"
  end

  def admin?
    role == "Admin"
  end

end
