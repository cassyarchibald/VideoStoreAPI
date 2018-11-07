class Movie < ApplicationRecord

  # Sets default value of available inventory to inventory
  before_save :set_available_inventory_default

  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true

  def check_inventory
    self.inventory > 0 ? true : false
  end

  def reduce_inventory
    check_inventory ? self.inventory -= 1 : false
  end

  def number_of_checked_out_movies
    self.rentals.length
  end

  private

  def set_available_inventory_default
    self.available_inventory = self.inventory - number_of_checked_out_movies
  end



end
