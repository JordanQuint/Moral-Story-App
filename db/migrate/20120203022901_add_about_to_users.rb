class AddAboutToUsers < ActiveRecord::Migration
  def change
    add_column :users, :about, :string, :limit => 800
  end
end
