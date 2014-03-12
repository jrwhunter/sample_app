class AddGroupToHills < ActiveRecord::Migration
  def change
    add_column :hills, :group, :integer
  end
end
