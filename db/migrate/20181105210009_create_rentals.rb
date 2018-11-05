class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.date :checkout_date
      t.date :checkin_date
      t.date :due_date
      t.belongs_to :movies, index: true, foreign_key: true
      t.belongs_to :customers, index: true, foreign_key: true

      t.timestamps
    end
  end
end
