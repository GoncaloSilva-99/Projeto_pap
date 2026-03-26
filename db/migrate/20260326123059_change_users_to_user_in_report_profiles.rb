class ChangeUsersToUserInReportProfiles < ActiveRecord::Migration[8.0]
  def change  
    remove_column :report_profiles, :users_id
  end
end
