class AddMacrosToDonuts < ActiveRecord::Migration
  def change
    add_column :donuts, :fat, :integer
    add_column :donuts, :carb, :integer
    add_column :donuts, :protein, :integer
  end
end
