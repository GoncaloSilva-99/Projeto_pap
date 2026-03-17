class CreateReportPosts < ActiveRecord::Migration[8.0]
  def change
    create_table :report_posts do |t|
      t.references :post, null: false, foreign_key: true
      t.text :content
      t.boolean :resolved

      t.timestamps
    end
  end
end
