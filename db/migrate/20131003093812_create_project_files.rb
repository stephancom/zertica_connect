class CreateProjectFiles < ActiveRecord::Migration
  def change
    create_table :project_files do |t|
      t.references :project, index: true, null: false
      t.string :url, null: false
      t.string :filename, null: false
      t.integer :size, null: false
      t.string :mimetype, null: false

      t.timestamps
    end
  end
end
