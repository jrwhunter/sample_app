class AddCategoryToHills < ActiveRecord::Migration
  def change
    add_column :hills, :category, :string
  end
end
