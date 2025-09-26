json.extract! admin_profile, :id, :user_id, :name, :created_at, :updated_at
json.url admin_profile_url(admin_profile, format: :json)
