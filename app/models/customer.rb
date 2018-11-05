class Customer < ApplicationRecord
  has_many :movies, through: :rentals
  validates_presence_of :name, :registered_at, :address, :city, :state, :postal_code, :phone

end
