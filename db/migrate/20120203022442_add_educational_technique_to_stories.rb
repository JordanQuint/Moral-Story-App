class AddEducationalTechniqueToStories < ActiveRecord::Migration
  def change
    add_column :stories, :educational_technique, :string
  end
end
