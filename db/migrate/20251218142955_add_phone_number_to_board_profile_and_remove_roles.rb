class AddPhoneNumberToBoardProfileAndRemoveRoles < ActiveRecord::Migration[8.0]
  def change
    add_column :board_profiles, :contact, :integer
    remove_column :board_profiles, :role, :string
  end
end
