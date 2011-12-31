class AddAgeTopicCharacteristicsToStory < ActiveRecord::Migration
  def change
    add_column :stories, :age, :string, {:limit => 8, :default => nil}
    add_column :stories, :topic, :string, {:limit => 50, :default => nil}
    add_column :stories, :characteristic, :string, {:limit => 50, :default => nil}
  end
end
