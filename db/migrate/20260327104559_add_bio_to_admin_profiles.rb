class AddBioToAdminProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :admin_profiles, :bio, :text
  end
end