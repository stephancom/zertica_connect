class RemoveStateFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :state, :string
  end
end
