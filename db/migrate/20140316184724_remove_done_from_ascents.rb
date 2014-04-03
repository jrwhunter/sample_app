class RemoveDoneFromAscents < ActiveRecord::Migration
  def change
  	remove_column :ascents, :done, :boolean
  end
end
