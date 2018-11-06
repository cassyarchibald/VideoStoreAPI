require "test_helper"

describe Rental do
  describe 'validations' do
    let(:complete_rental){
      Rental.new(
      checkout_date: (Date.today - 1),
      checkin_date: Date.today,
      due_date: Date.today + 6,
      movie: scary,
      customer: cassy
        )
    }

    it "must be valid with all fields" do
      value(complete_rental).must_be :valid
    end

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
