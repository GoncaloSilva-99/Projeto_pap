class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :role, presence: true, inclusion: {in: ["User", "Player", "Coach", "Club", "Board", "Admin", "SuperAdmin"]}
  validates :email, presence: true

  # Allow email confirmation in forms.
  attr_accessor :email_confirmation
  validates :email, confirmation: true, if: -> { email_confirmation.present? }
  validates :email_confirmation, presence: true, on: :update, if: -> { email_changed? }

  # Devise already validates password presence on create.
  # These validations allow updating other attributes without requiring a password change.
  validates :password, confirmation: true, if: :password_required?
  validates :password_confirmation, presence: true, on: :update, if: :password_required?

  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end

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

  def super_admin?
    role == "SuperAdmin"
  end

  REGEX_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  has_many :posts, dependent: :destroy
  
  has_many :post_comments, dependent: :destroy
  has_many :post_views, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  
  has_many :following_relationships, class_name: 'Follow', foreign_key: :follower_id, dependent: :destroy
  has_many :following, through: :following_relationships, source: :followed

  has_many :follower_relationships, class_name: 'Follow', foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :post_saves, dependent: :destroy
  has_many :saved_posts, through: :post_saves, source: :post

  has_many :post_likes, dependent: :destroy
  has_many :liked_posts, through: :post_likes, source: :post

  has_many :report_posts, dependent: :destroy
  has_many :report_profiles, dependent: :destroy
  has_many :report_comments, dependent: :destroy

  def follow(other_user)
    return false if self == other_user || following?(other_user)
    following_relationships.create(followed: other_user)
  end

  def unfollow(other_user)
    relationship = following_relationships.find_by(followed: other_user)
    relationship&.destroy
  end


  def following?(other_user)
    following.include?(other_user)
  end

  def following_count
    following.count
  end

  def followers_count
    followers.count
  end

  def feed_posts(page: 1, per_page: 25)
    followed_ids = following.pluck(:id) + [id]

    Post.from_users(followed_ids)
    .not_viewed_by(self)
    .recent
    .limit(per_page)
    .offset((page - 1) * per_page)
  end

  def discover_posts(page: 1, per_page: 10)
    excluded_ids = following.pluck(:id) + [id]

    Post.where.not(user_id: excluded_ids)
    .not_viewed_by(self)
    .recent
    .limit(per_page)
    .offset((page - 1) * per_page)
  end

  def suggested_users_to_follow(limit: 6)
    excluded_ids = following.pluck(:id) + [id]

    User.where.not(id: excluded_ids)
    .where.not(role: 'admin')
    .left_joins(:follower_relationships)
    .group('users.id')
    .order('COUNT(follows.id) DESC')
    .limit(limit)
  end

  

end
