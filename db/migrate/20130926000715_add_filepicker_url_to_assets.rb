class AddFilepickerUrlToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :filepicker_url, :string
  end
end
