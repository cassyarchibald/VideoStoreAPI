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
      # Saving movie triggers the available_inventory

    else
      render json: {
        ok: false,
        message: rental.errors.messages
      }, status: :bad_request
    end
  end

  def checkin
    movie_id = params[:rental][:movie_id]
    customer_id = params[:rental][:customer_id]
    rental = Rental.find_by(movie_id: movie_id, customer_id: customer_id)
    if rental.check_in!
      # binding.pry

      render json: {
        ok: true,
        rental: rental.as_json(only: [ :customer_id, :movie_id ] )
      }, status: :ok

    else
      render json: {
        ok: false,
        message: rental.errors.messages
      }, status: :bad_request
    end
  end



  private

  def rental_params
    return params.require(:rental).permit(:movie_id, :customer_id, :checkout_date, :due_date, :checkin_date)
  end



end
