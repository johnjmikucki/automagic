class DonutDefaultUnreleased < ActiveRecord::Migration
  def change
    change_column_default :donuts, :released, false
  end
end
