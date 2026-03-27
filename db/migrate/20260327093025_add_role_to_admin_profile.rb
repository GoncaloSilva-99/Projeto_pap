class AddRoleToAdminProfile < ActiveRecord::Migration[8.0]
  def change
    add_column :admin_profiles, :role, :string
  end
end
