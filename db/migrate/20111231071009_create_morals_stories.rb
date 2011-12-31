class CreateMoralsStories < ActiveRecord::Migration
  def change
    create_table :morals_stories do |t|
      t.integer :id, {:limit => 10, :null => false}
      t.integer :story_id, {:limit => 10, :null => false}
      t.integer :moral_id, {:limit => 10, :null => false}

      t.timestamps
    end
  end
end
