class CreateChorepairings < ActiveRecord::Migration
  def change
    create_table :chorepairings do |t|
      t.integer :user_id
      t.integer :chore_id

      t.timestamps null: false
    end
  end
end
