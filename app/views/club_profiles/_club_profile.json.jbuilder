json.extract! club_profile, :id, :user_id, :name, :status, :approved_by, :created_at, :updated_at
json.url club_profile_url(club_profile, format: :json)
