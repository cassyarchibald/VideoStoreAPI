class UpdateIdsInRentalstoSingular < ActiveRecord::Migration[5.2]
  def change
    rename_column :rentals, :movies_id, :movie_id
    rename_column :rentals, :customers_id, :customer_id 
  end
end
