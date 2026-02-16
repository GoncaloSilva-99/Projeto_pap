json.extract! post, :id, :user_id, :content, :likes_count, :comments_count, :views_count, :created_at, :updated_at
json.url post_url(post, format: :json)
