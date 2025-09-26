class CreateCoachProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :coach_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.date :birth_date
      t.references :club_profile, null: false, foreign_key: true
      t.string :coach_type

      t.timestamps
    end
  end
end
