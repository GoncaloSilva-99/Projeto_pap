class DropReportsTables < ActiveRecord::Migration[8.0]
  def change
    drop_table :report_posts
    drop_table :report_comments
  end
end
