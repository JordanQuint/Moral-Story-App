class RenameFromToCausedByInNotifications < ActiveRecord::Migration
  def up
    rename_column :notifications, :from, :caused_by
  end

  def down
    rename_column :notifications, :caused_by, :from
  end
end
