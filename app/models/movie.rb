class Movie < ApplicationRecord

  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true

  def number_of_checked_out_movies
    return Rental.all.select{ |rental| rental.movie_id == self.id && rental.checkin_date.nil?}.length
  end

  def available_inventory
    return self.inventory - number_of_checked_out_movies
  end
end
