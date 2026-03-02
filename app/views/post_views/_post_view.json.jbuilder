json.extract! post_view, :id, :user_id, :post_id, :created_at, :updated_at
json.url post_view_url(post_view, format: :json)
