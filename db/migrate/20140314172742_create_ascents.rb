class CreateAscents < ActiveRecord::Migration
  def change
    create_table :ascents do |t|
      t.integer :user
      t.integer :hill
      t.boolean :done
      t.date :date
      t.string :notes

      t.timestamps
    end

    add_index :ascents, :user
    add_index :ascents, :hill
    add_index :ascents, [:user, :hill], unique: true
  end
end
