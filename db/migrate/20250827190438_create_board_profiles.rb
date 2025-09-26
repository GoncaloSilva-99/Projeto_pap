class CreateBoardProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :board_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :bio
      t.date :birth_date
      t.references :club_profile, null: false, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
