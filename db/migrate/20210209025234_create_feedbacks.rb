class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.integer :user_id
      t.integer :team_id
      t.integer :goal_rating#, null: false
      t.integer :communication_rating#, null: false
      t.integer :positive_rating#, null: false
      t.integer :reach_rating#, null: false
      t.integer :bounce_rating#, null: false
      t.integer :account_rating#, null: false
      t.integer :decision_rating#, null: false
      t.integer  :respect_rating#, null: false
      t.integer :rating#, null: false
      t.string :comments, limit: 255
      t.string :progress_comments#, limit: 255
      t.datetime :timestamp

      t.timestamps
    end
  end
end
