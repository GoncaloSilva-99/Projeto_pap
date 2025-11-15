class AddSportbioandContactToCoachProfile < ActiveRecord::Migration[8.0]
  def change
    add_column :coach_profiles, :sport, :string
    add_column :coach_profiles, :bio, :string
    add_column :coach_profiles, :contact, :integer
  end
end
