class AddDefaultToReportProfilesResolved < ActiveRecord::Migration[8.0]
  def change
    change_column_default :report_profiles, :resolved, from: nil, to: false
  end
end
