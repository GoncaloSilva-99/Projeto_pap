class CreateClubProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :club_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.boolean :status
      t.integer :approved_by

      t.timestamps
    end
  end
end
