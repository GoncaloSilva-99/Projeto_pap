class AddThingsToReportProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :banned_by, :integer
    add_column :users, :ban_reason, :text
    add_column :report_profiles, :admin_observations, :text
    add_column :report_profiles, :resolved_by, :integer
  end
end
