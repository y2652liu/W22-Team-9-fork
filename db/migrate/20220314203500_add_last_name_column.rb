class AddLastNameColumn < ActiveRecord::Migration[6.0]
    def change

        add_column :users, :lastname, :string, null: false, limit: 255 

    end
end