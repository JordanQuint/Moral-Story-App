class AddShowNameShowEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :show_name, :boolean, :default => false
    add_column :users, :show_email, :boolean, :default => false
  end
end
