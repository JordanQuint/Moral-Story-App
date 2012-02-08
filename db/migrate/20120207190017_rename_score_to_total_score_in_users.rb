class RenameScoreToTotalScoreInUsers < ActiveRecord::Migration
  def up
    rename_column :users, :score, :total_score
  end

  def down
    rename_column :users, :total_score, :score
  end
end
