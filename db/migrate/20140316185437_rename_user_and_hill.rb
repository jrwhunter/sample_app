class RenameUserAndHill < ActiveRecord::Migration
  def change
    change_table :ascents do |t|
      t.rename :user, :user_id
      t.rename :hill, :hill_id
    end
  end
end
