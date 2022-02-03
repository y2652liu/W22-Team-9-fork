class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :team_code
      t.string :team_name
      t.references :user
      t.timestamps
    end
  end
end