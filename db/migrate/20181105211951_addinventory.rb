class Addinventory < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :inventory, :integer
  end
end
