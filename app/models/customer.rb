class Customer < ApplicationRecord
  before_create :set_registered_at

  has_many :rentals
  has_many :movies, through: :rentals
  validates_presence_of :name, :address, :city, :state, :postal_code, :phone

  # Just calculate the total movies here and pass to controller
  def movies_checked_out_count
    # Maybe set status to show "active" rentals later
    self.rentals.length
  end

    # def add_movie_to_count
    #   # How do I access the movies checked out count
    #   # For this customer?
    #   # TODO customer.rentals.length based on if active or inactive
    #   self.movies_checked_out_count += 1
    # end

  private
    def set_registered_at
      self.registered_at = self.created_at
    end


end
