class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :created_by_user_id
      t.integer :story_one_id
      t.integer :story_two_id
      t.string :description, :limit => 120

      t.timestamps
    end
  end
end
