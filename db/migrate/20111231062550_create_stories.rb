class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer :id, {:limit => 10, :null => false}
      t.integer :user_id, {:limit => 10, :null => false}
      t.integer :moral_id, {:limit => 10, :null => false}
      t.string :title, {:limit => 80}
      t.string :story, {:limit => 8191}

      t.timestamps
    end
  end
end
