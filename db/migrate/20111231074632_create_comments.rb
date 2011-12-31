class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :id, {:limit => 10, :null => false}
      t.integer :user_id, {:limit => 10, :null => false}
      t.integer :story_id, {:limit => 10, :null => false}
      t.string :content, {:limit => 600, :null => false}

      t.timestamps
    end
  end
end
