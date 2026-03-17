class CreateClubExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :club_expenses do |t|
      t.references :club_profile, null: false, foreign_key: true
      t.decimal :value, null: false
      t.string :description
      t.date :date, null: false
      t.timestamps
    end
  end
end
