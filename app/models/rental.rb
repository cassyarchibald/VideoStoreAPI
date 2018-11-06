class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  validates_presence_of :checkout_date, :due_date, :movie_id, :customer_id
end
