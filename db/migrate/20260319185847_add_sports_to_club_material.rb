class AddSportsToClubMaterial < ActiveRecord::Migration[8.0]
  def change
    add_column :club_materials, :sport, :string
  end
end
