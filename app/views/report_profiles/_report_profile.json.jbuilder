json.extract! report_profile, :id, :users_id, :content, :resolved, :created_at, :updated_at
json.url report_profile_url(report_profile, format: :json)
