json.extract! club_expense, :id, :club_profile_id, :value, :description, :date, :created_at, :updated_at
json.url club_expense_url(club_expense, format: :json)
