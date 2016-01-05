class CreateChoretypes < ActiveRecord::Migration
  def change
    create_table :choretypes do |t|
      t.string :type

      t.timestamps null: false
    end
  end
end
