class RentalsController < ApplicationController

  def checkout
    rental = Rental.create(rental_params)
      # binding.pry 
    # If it's able to be saved,
    # We'll have the created_at value we need
    if rental.save
      rental.set_checkout_values!
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

  def checkin
    movie_id = params[:rental][:movie_id]
    customer_id = params[:rental][:customer_id]
    rental = Rental.find_by(movie_id: movie_id, customer_id: customer_id)
    if rental.check_in!

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
