class RemoveTotalScoreFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :total_score
  end

  def down
    add_column :users, :total_score, :integer
  end
end
