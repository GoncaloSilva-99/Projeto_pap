class CreateClubMaterials < ActiveRecord::Migration[8.0]
  def change
    create_table :club_materials do |t|
      t.references :club_profile, null: false, foreign_key: true
      t.string :name
      t.string :quantity
      t.string :description

      t.timestamps
    end
  end
end
