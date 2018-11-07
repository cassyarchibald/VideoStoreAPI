require "test_helper"

describe Rental do
  # Does not know what scary or customer is
  # let(:customer){customers[:cassy]}
  # let(:movie){movies[:funny]}
  describe 'validations' do
    let(:complete_rental){
      Rental.new checkout_date: (Date.today - 1),
      checkin_date: Date.today,
      due_date: Date.today + 6,
      # movie: Movie.first,
      # customer: Customer.first
      movie_id: movies(:scary).id,
      customer_id: customer(:cassy).id
    }

    it "must be valid with all fields" do
      value(complete_rental).must_be :valid?
    end

    it "is invalid if checkout date is missing" do
      # binding.pry
      complete_rental.checkout_date = nil
      result = complete_rental.valid?
      result.must_equal false
      expect(complete_rental.errors).must_include "checkout_date"
    end

    it "is invalid if due_date is missing" do
      complete_rental.due_date = nil
      result = complete_rental.valid?
      result.must_equal false
      expect(complete_rental.errors).must_include "due_date"
    end

    it "is invalid if movie is missing" do
      complete_rental.movie_id = nil
      result = complete_rental.valid?
      result.must_equal false
      expect(complete_rental.errors).must_include "movie_id"
    end

    it "is invalid if customer is missing" do
      complete_rental.customer_id = nil
      result = complete_rental.valid?
      result.must_equal false
      expect(complete_rental.errors).must_include "customer_id"
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
