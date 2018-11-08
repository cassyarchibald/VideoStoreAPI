require "test_helper"

describe Rental do

  describe 'validations' do
    let(:complete_rental){
      Rental.new checkout_date: (Date.today - 1),
      checkin_date: Date.today,
      due_date: Date.today + 6,
      movie_id: movies(:scary).id,
      customer_id: customers(:cassy).id
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

    ##### TODO #######
    # Do we need to test that it breaks without a customer/movie?
    # Can't do that to movie as if movie is nil then custom validator breaks
    # What about independent destroy or nullify for if one of those get deleted?
    #
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

  # describe "custom logic" do
  #   # Logic for movie available inventory
  #   # will live in rental controller test
  #   # as that happens only after a rental post request
    # let(:movie){
    #   Movie.create title: "What Dreams May Come",
    #   overview: "Very artsy movie",
    #   release_date: Date.today,
    #   inventory: 3
    # }

    # before do
    #  # Creating a rental to reduce available inventory
    #  binding.pry
    #   Rental.create checkout_date: (Date.today - 1),
    #   checkin_date: Date.today,
    #   due_date: Date.today + 6,
    #   movie_id: movie.id,
    #   customer_id: customers(:cassy).id
    # end

  end
