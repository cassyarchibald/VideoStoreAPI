class Changeinventorytointeger < ActiveRecord::Migration[5.2]
  def change
    remove_column :movies, :inventory
  end
end
