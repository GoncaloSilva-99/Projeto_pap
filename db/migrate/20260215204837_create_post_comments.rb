class CreatePostComments < ActiveRecord::Migration[8.0]
  def change
    create_table :post_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.text :content, null: false

      t.timestamps
    end
  end
end
