class CreateOrdersProjectFiles < ActiveRecord::Migration
  def change
    create_table :orders_project_files, id: false do |t|
      t.references :order, index: true
      t.references :project_file, index: true
    end

    add_index :orders_project_files, [:order_id, :project_file_id]
    # TODO: OOPS!  forgot unique: true
  end
end
