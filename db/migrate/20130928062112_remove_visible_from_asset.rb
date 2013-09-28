class RemoveVisibleFromAsset < ActiveRecord::Migration
  def change
    remove_column :assets, :visible, :boolean
  end
end
