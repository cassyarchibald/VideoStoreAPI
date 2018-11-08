class RentalsController < ApplicationController

  def checkout
    rental = Rental.new(rental_params)

    if rental.save
      render json: {
        ok: true,
        # Only returning the customer and movie ids
        rental: rental.as_json(only: [ :customer_id, :movie_id ] )
      }, status: :ok

      # Reduce the inventory (should reduce the inventory/save the movie)
      # Saving movie triggers the set_available_inventory
      # binding.pry
      # binding.pry
      # Do calculation - Don't need a calculation....
      rental.movie.reduce_inventory

      # Add to customer checked out count
      rental.customer.add_movie_to_count

    else
      render json: {
        ok: false,
        message: rental.errors.messages
      }, status: :bad_request
    end
  end


  private

  def rental_params
    params.require(:rental).permit(:checkout_date, :due_date, :checkin_date, :movie_id, :customer_id)
  end

end
