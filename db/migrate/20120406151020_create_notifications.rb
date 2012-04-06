class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id, :null => false, :limit => 15
      t.string :from, :null => false, :limit => 30
      t.integer :target_id, :limit => 15, :null => false
      t.boolean :viewed, :default => false, :null => false

      t.timestamps
    end
  end
end
