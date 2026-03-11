class CreateReportProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :report_profiles do |t|
      t.references :users, null: false, foreign_key: true
      t.text :content
      t.boolean :resolved

      t.timestamps
    end
  end
end
