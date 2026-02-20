class Post < ApplicationRecord
  belongs_to :user
  has_many :post_likes, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_views, dependent: :destroy

  has_many_attached :images

  validates :content, presence: true, length: { minimum: 1, maximum: 5000 }
  validate :acceptable_images


  scope :recent, -> { order(created_at: :desc) }

  scope :from_users, ->(user_ids) { where(user_id: user_ids) }

  scope :not_viewed_by, ->(user) {
    left_joins(:post_views)
    .where(post_views: { user_id: nil })
    .or(where.not(post_views: { user_id: user.id }))
    .distinct
  }

  def liked_by?(user)
    return false unless user
    post_likes.exists?(user: user)
  end

  def mark_as_viewed_by(user)
    post_views.find_or_create_by(user: user) do |view|
      view.viewed_at = Time.current 
    end
  end

  def images_count
    images.count
  end

  def acceptable_images
    return unless images.attached?

    if images.count > 10
      errors.add(:images, "não pode ter mais de 10 imagens (tens #{images.count})")
      return
    end

    acceptable_types = %w[image/jpeg image/jpg image/png image/gif image/webp]
    max_size = 10.megabytes

    images.each do |image|
      unless image.content_type.in?(acceptable_types)
        errors.add(:images, "#{image.filename} não é válida (apenas JPG, PNG, GIF, WEBP)")
      end
      
      if image.byte_size > max_size
        size_mb = (image.byte_size / 1.megabyte.to_f).round(2)
        errors.add(:images, "#{image.filename} é muito grande (#{size_mb}MB, máx 10MB)")
      end
    end  
  end  




end
