class RemoveCharacteristicFromStories < ActiveRecord::Migration
  def up
    remove_column :stories, :characteristic
  end

  def down
    add_column :stories, :characteristic, :string
  end
end
