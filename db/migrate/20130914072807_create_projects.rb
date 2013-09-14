class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, null: false, default: 'New Project'
      t.string :state, null: false, default: 'preparing'
      t.references :user, index: true, null: false
      t.text :spec
      t.date :deadline

      t.timestamps
    end
  end
end
