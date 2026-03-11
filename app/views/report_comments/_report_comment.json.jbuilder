json.extract! report_comment, :id, :post_comment_id, :content, :resolved, :created_at, :updated_at
json.url report_comment_url(report_comment, format: :json)
