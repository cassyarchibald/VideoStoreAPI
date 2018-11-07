class Customer < ApplicationRecord
  before_create :set_registered_at

  has_many :rentals
  has_many :movies, through: :rentals
  validates_presence_of :name, :address, :city, :state, :postal_code, :phone

  private
    def set_registered_at
      self.registered_at = self.created_at
    end

end
