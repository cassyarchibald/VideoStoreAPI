class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :overview
      t.date :release_date
      t.string :inventory

      t.timestamps
    end
  end
end
