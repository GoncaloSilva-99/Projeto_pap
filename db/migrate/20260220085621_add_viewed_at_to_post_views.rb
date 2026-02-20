class AddViewedAtToPostViews < ActiveRecord::Migration[8.0]
  def change
    add_column :post_views, :viewed_at, :datetime
  end
end
