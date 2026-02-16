json.extract! post_comment, :id, :user_id, :post_id, :content, :created_at, :updated_at
json.url post_comment_url(post_comment, format: :json)
