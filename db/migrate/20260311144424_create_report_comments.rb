class CreateReportComments < ActiveRecord::Migration[8.0]
  def change
    create_table :report_comments do |t|
      t.references :post_comment, null: false, foreign_key: true
      t.text :content
      t.boolean :resolved

      t.timestamps
    end
  end
end
