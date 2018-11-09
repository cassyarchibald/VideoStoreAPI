class Movie < ApplicationRecord
  # before_create :set_available_inventory
  # before_save :set_available_inventory

  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true

  def number_of_checked_out_movies
    # Might add a flag later for "active rentals"
    return Rental.all.select{ |rental| rental.movie_id == self.id && rental.checkin_date.nil?}.length
  end

  def available_inventory
    return self.inventory - number_of_checked_out_movies
  end


  # If we add validation to rental that movie inventory must be > 0
  # We won't need this logic
  # def check_inventory
  #   self.inventory > 0 ? true : false
  # end

  # Don't need to do this
  # Have available_inventory attribute set to return as method
  # def reduce_inventory
  #   if check_inventory
  #     # binding.pry
  #     # self.inventory -= 1
  #     binding.pry
  #      self.available_inventory = self.inventory - number_of_checked_out_movies
  #
  #     # Saving movie should trigger an update to
  #     # set_available_inventory
  #     self.save
  #   else
  #     # binding.pry
  #     return false
  #   end
end
