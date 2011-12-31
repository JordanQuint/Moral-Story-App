class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :id, {:limit => 10, :null => false}
      t.string :name, {:limit => 100, :null => false}
      t.string :username, {:limit => 20, :null => false}
      t.string :password, {:limit => 50, :null => false}
      t.string :email, {:limit => 80, :null => false}
      t.integer :score, {:limit => 12, :default => 0, :null => false}

      t.timestamps
    end
  end
end
