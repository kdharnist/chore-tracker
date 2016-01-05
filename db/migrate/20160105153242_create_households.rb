class CreateHouseholds < ActiveRecord::Migration
  def change
    create_table :households do |t|
      t.string :name
      t.integer :members

      t.timestamps null: false
    end
  end
end
