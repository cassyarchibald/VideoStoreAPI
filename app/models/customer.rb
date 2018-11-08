class Customer < ApplicationRecord
  before_create :set_registered_at
  before_save :set_registered_at

  has_many :rentals
  has_many :movies, through: :rentals
  validates_presence_of :name, :address, :city, :state, :postal_code, :phone

  # Calculate the total movies here and pass to controller
  def movies_checked_out_count
    # Maybe set status to show "active" rentals later
    return Rental.where(customer_id: self.id).length
  end

  private
    def set_registered_at
      self.registered_at = self.created_at
    end

end
