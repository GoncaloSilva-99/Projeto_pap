class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :role, presence: true, inclusion: {in: ["User", "Player", "Coach", "Club", "Board", "Admin"]}
  validates_presence_of :email, :password, :password_confirmation

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

  REGEX_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  has_many :posts, dependent: :destroy
  has_many :post_likes, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_views, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  
  has_many :following_relationships, class_name: 'Follow', foreign_key: :follower_id, dependent: :destroy
  has_many :following, through: :following_relationships, source: :followed

  has_many :follower_relationships, class_name: 'Follow', foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

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
