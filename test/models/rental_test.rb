require "test_helper"

describe Rental do
  describe 'validations' do

  end

  describe 'relationships' do
    let(:rental) { rentals(:one) }

    it "has a movie" do
      rental.must_respond_to :movie
      rental.movie.must_be_kind_of Movie
    end

    it "has a customer" do
      rental.must_respond_to :customer
      rental.customer.must_be_kind_of Customer
    end

  end


end
