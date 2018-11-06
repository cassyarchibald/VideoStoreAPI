class Movie < ApplicationRecord

  # Sets default value of available inventory to inventory
  before_save :set_available_inventory_default

  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true

  private

  def set_available_inventory_default
    self.available_inventory = self.inventory
  end
end
