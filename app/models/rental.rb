class Rental < ApplicationRecord

  belongs_to :movie
  belongs_to :customer
  validates_presence_of :movie_id, :customer_id
  validate :available_inventory_of_movie

  def available_inventory_of_movie
    unless self.movie.available_inventory > 0
      errors.add(:available_inventory_of_movie, "Must be greater than 0")
    end
  end

  def check_in! #checks in a customer's rental(customer_id, movie_id)
    self.checkin_date = Date.today
    self.save
  end

  def set_checkout_values!
    set_checkout_date
    set_due_date
    self.save
  end

  private

  def set_checkout_date
    self.checkout_date = (self.created_at)
  end

  def set_due_date
    self.due_date = (self.checkout_date + 7)
  end
end
