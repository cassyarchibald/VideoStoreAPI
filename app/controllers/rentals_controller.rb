class RentalsController < ApplicationController

  def checkout
    rental = Rental.new(rental_params)

    if rental.save
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
    params.require(:rental).permit(:checkout_date, :due_date, :checkin_date, :movie_id, :customer_id)
  end
end
