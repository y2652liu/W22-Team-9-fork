class AddMotivationRating < ActiveRecord::Migration[6.0]
    def change

        add_column :feedbacks, :motivation_rating, :integer, :null => false

    end
end