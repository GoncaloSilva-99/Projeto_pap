json.extract! report_post, :id, :post_id, :content, :resolved, :created_at, :updated_at
json.url report_post_url(report_post, format: :json)
