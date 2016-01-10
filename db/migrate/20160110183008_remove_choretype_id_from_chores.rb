class RemoveChoretypeIdFromChores < ActiveRecord::Migration
  def change
    remove_column :chores, :choretype_id, :integer
  end
end
