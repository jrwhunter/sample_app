class AddClimbedToAscents < ActiveRecord::Migration
  def change
    add_column :ascents, :climbed, :boolean
  end
end
