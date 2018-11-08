class Movie < ApplicationRecord
  # before_create :set_available_inventory
  before_save :set_available_inventory

  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true

  def number_of_checked_out_movies
    self.rentals.length
  end

  def set_available_inventory
    # binding.pry
    self.available_inventory = self.inventory - number_of_checked_out_movies
  end

  def check_inventory
    self.inventory > 0 ? true : false
  end

  def reduce_inventory
    if check_inventory
      self.inventory -= 1
      # Saving movie should trigger an update to
      # set_available_inventory
      self.save
    else
      return false
    end
  end

  private

end
