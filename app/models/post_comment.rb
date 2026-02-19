class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true

  validates :content, presence: true, length: {minimum: 1, maximum: 1000}

  scope :oldest_first, -> { order(created_at: :asc) }
  scope :newest_first, -> { order(created_at: :desc) }


  def time_ago
    ActionController::Base.helpers.time_ago_in_words(created_at)
  end
end
