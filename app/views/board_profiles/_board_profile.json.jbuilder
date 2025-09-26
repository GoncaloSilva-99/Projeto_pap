json.extract! board_profile, :id, :user_id, :name, :bio, :birth_date, :club_profile_id, :role, :created_at, :updated_at
json.url board_profile_url(board_profile, format: :json)
