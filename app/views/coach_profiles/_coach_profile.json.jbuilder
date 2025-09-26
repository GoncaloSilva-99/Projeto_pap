json.extract! coach_profile, :id, :user_id, :name, :birth_date, :club_id, :coach_type, :created_at, :updated_at
json.url coach_profile_url(coach_profile, format: :json)
