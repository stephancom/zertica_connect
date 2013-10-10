class CreateOrdersShippableFiles < ActiveRecord::Migration
  def change
    create_table :orders_shippable_files, id: false do |t|
      t.references :order, index: true
      t.references :project_file, index: true
    end

    add_index :orders_shippable_files, [:order_id, :project_file_id], unique: true
  end
end
