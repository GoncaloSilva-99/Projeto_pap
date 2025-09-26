class CreatePlayerProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :player_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.date :birth_date
      t.string :position
      t.text :bio
      t.integer :contact
      t.integer :parents_contact
      t.references :club_profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
