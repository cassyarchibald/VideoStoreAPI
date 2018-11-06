require "test_helper"

describe Customer do
  # Add fixture let blocks here


  describe "validations" do
    let(:complete_customer) {
      Customer.new name: "Cassy",
      registered_at: DateTime.new(2018,11,3),
      address: "123 Sunny Lane",
      city: "Seattle",
      state: "Washington",
      postal_code: "98133",
      phone: "999-999-9999"
    }

    it "must be valid" do
      value(complete_customer).must_be :valid?
    end

    it "is invalid if name is missing" do
      complete_customer.name = nil
      result = complete_customer.valid?
      result.must_equal false
      expect(complete_customer.errors).must_include "name"
    end

    it "is invalid if registered_at is missing" do
      complete_customer.registered_at = nil
      result = complete_customer.valid?
      result.must_equal false
      expect(complete_customer.errors).must_include "registered_at"
    end

    it "is invalid if address is missing" do
      complete_customer.address = nil
      result = complete_customer.valid?
      result.must_equal false
      expect(complete_customer.errors).must_include "address"
    end

    it "is invalid if city is missing" do
      complete_customer.city = nil
      result = complete_customer.valid?
      result.must_equal false
      expect(complete_customer.errors).must_include "city"
    end

    it "is invalid if state is missing" do
      complete_customer.state = nil
      result = complete_customer.valid?
      result.must_equal false
      expect(complete_customer.errors).must_include "state"
    end

    it "is invalid if postal code is missing" do
      complete_customer.postal_code = nil
      result = complete_customer.valid?
      result.must_equal false
      expect(complete_customer.errors).must_include "postal_code"
    end

    it "is invalid if phone is missing" do
      complete_customer.phone = nil
      result = complete_customer.valid?
      result.must_equal false
      expect(complete_customer.errors).must_include "phone"
    end

  end

  describe "relationships" do
    let(:movie) { movies(:funny) }
    let(:customer) { customers(:shelan) }

    it "has a list of movies" do
      # Act = Add a movie?
      customer.must_respond_to :movies
      customer.movies.each do |movie|
        movie.must_be_kind_of Movie
      end
    end

    it "has a list of rentals" do
      customer.must_respond_to :rentals
      customer.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end
  end
end 
