class RenameMoralIdToMoralInStories < ActiveRecord::Migration
  def up
    remove_column :stories, :moral_id
    add_column :stories, :moral, :string, :limit => 80
  end

  def down
    remove_column :stories, :moral
    add_column :stories, :moral_id, :integer
  end
end
