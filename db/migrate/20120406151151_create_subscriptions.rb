class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id, :null => false, :limit => 15
      t.string :subscribed_to, :null => false, :limit => 30
      t.integer :target_id, :null => false, :limit => 15

      t.timestamps
    end
  end
end
