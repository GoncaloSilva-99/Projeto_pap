class AddReportedByToReportProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :report_profiles, :reported_by, :integer 
  end
end
