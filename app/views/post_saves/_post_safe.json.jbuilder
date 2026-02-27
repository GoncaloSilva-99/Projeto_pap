json.extract! post_safe, :id, :user_id, :post_id, :created_at, :updated_at
json.url post_safe_url(post_safe, format: :json)
