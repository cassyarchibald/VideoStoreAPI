class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  validates_presence_of :checkout_date, :due_date, :movie_id, :customer_id
  validate :available_inventory_of_movie

  def available_inventory_of_movie
    unless self.movie.available_inventory > 0
      errors.add(:available_inventory_of_movie, "Must be greater than 0")
    end
  end


end
