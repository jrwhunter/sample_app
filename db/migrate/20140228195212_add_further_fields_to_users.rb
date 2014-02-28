class AddFurtherFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
    add_column :users, :club, :string
    add_column :users, :visible, :boolean
    add_column :users, :preferences, :string
    add_column :users, :favourites, :string
  end
end
