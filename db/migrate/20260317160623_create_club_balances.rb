class CreateClubBalances < ActiveRecord::Migration[8.0]
  def change
    create_table :club_balances do |t|
      t.references :club_profile, null: false, foreign_key: true
      t.decimal :value, default: 0

      t.timestamps
    end
  end
end
