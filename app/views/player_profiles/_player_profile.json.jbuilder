json.extract! player_profile, :id, :user_id, :name, :birth_date, :position, :bio, :contact, :parents_contact, :club_profile_id, :created_at, :updated_at
json.url player_profile_url(player_profile, format: :json)
