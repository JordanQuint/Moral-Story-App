class CreateMorals < ActiveRecord::Migration
  def change
    create_table :morals do |t|
      t.integer :id, {:limit => 10, :null => false}
      t.string :content, {:limit => 70, :null => false}

      t.timestamps
    end
  end
end
