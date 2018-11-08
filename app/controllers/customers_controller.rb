class CustomersController < ApplicationController
  def index
    customers = Customer.all.order(:name)
    movies_checked_out_count = movies_checked_out_count
    render json: customers.as_json( methods: :movies_checked_out_count, only: [:id, :name, :registered_at, :postal_code, :phone, "movies_checked_out_count" => movies_checked_out_count]), status: :ok
  end
end
