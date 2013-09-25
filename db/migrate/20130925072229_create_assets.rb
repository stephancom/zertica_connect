class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.references :project, index: true, null: false
      t.string :title, null: true
      t.text :notes
      t.boolean :visible, null: false, default: true

      t.timestamps
    end
  end
end
