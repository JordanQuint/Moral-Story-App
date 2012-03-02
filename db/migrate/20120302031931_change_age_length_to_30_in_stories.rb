class ChangeAgeLengthTo30InStories < ActiveRecord::Migration
  def up
    change_column :stories, :age, :string, {:limit => 30, :default => nil}
  end

  def down
    change_column :stories, :age, :string, {:limit => 8, :default => nil}
  end
end
