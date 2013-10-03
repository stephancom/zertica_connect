class CreateProjectFiles < ActiveRecord::Migration
  def change
    create_table :project_files do |t|
      t.references :project, index: true, null: false
      t.string :url, null: false
      t.hstore :data

      t.timestamps
    end
  end
end
