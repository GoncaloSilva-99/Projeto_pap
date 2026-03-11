class AddUsersToReposts < ActiveRecord::Migration[8.0]
  def change
    add_reference :report_posts, :user, null: false, foreign_key: true
    add_reference :report_profiles, :user, null: false, foreign_key: true
    add_reference :report_comments, :user, null: false, foreign_key: true
  end
end
