class ChangeCommentStructure < ActiveRecord::Migration
  def up
    remove_column :comments, :story_id
    add_column :comments, :comment_on_table, :string, :limit => 50, :null => false
    add_column :comments, :comment_on_id, :integer, :limit => 6, :null => false
  end

  def down
    remove_column :comments, :comment_on_table
    remove_column :comments, :comment_on_id
    add_column :comments, :story_id, :integer
  end
end
