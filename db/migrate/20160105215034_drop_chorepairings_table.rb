class DropChorepairingsTable < ActiveRecord::Migration
  def up
    drop_table :chorepairings
  end

  def down
    create_table :chorepairings
  end
end

