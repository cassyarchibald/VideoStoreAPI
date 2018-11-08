class Rental < ApplicationRecord
  before_create :set_checkout_date, :set_due_date

  belongs_to :movie
  belongs_to :customer
  validates_presence_of :movie_id, :customer_id
  validate :available_inventory_of_movie

  def available_inventory_of_movie
    unless self.movie.available_inventory > 0
      errors.add(:available_inventory_of_movie, "Must be greater than 0")
    end
  end

  private
  def set_checkout_date
    self.checkout_date = self.created_at
  end

  def set_due_date
    self.due_date = self.checkout_date + 7
  end


end
