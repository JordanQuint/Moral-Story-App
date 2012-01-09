class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :id, {:limit => 10, :null => false}
      t.string :name, {:limit => 100}
      t.string :username, {:limit => 20}
      t.string :encrypted_password
      t.string :email, {:limit => 80}
      t.integer :score, {:limit => 12, :default => 0}

      t.timestamps
    end
  end
end
