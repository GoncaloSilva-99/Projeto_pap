class AddFieldsForClubProfile < ActiveRecord::Migration[8.0]
  def change
    add_column :club_profiles, :bio, :text
    add_column :club_profiles, :foundation_date, :date
    add_column :club_profiles, :contact, :integer 
  end
end
