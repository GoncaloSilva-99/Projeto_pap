class AddNameToTrainings < ActiveRecord::Migration[8.0]
  def change
    add_column :club_team_trainings, :name, :string
  end
end
