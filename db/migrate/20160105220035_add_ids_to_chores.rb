class AddIdsToChores < ActiveRecord::Migration
  def change
    add_column :chores, :user_id, :integer
    add_column :chores, :choretype_id, :integer
  end
end
