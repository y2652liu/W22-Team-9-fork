class CreateNewFeedbacks < ActiveRecord::Migration[6.0]
    def change

        add_column :feedbacks, :goal_rating, :integer, :null => false
        add_column :feedbacks, :communication_rating, :integer, :null => false
        add_column :feedbacks, :positive_rating, :integer, :null => false
        add_column :feedbacks, :reach_rating, :integer, :null => false
        add_column :feedbacks, :bounce_rating, :integer, :null => false
        add_column :feedbacks, :account_rating, :integer, :null => false
        add_column :feedbacks, :decision_rating, :integer, :null => false
        add_column :feedbacks, :respect_rating, :integer, :null => false
        add_column :feedbacks, :progress_comments, :string, :null => false

    end
end