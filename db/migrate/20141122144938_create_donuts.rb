class CreateDonuts < ActiveRecord::Migration
  def change
    create_table :donuts do |t|
      t.string :name
      t.text :ad_copy
      t.boolean :released

      t.timestamps null: false
    end
    add_index :donuts, :name, unique: true
  end
end
