class DropChoretypeTable < ActiveRecord::Migration
  def up
    drop_table :choretypes
  end

  def down
    create_table :choretypes
  end

end
