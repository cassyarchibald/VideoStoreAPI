require "test_helper"

describe Movie do
  let(:complete_movie) {
    Movie.create title: "Cher",
    overview: "The Best Movie",
    release_date: DateTime.new(2018,11,3),
    inventory: 2
  }

  describe "validations" do
    it "must be valid" do
      value(complete_movie).must_be :valid?
    end

    it "is invalid if title is missing" do
      complete_movie.title = nil
      result = complete_movie.valid?
      result.must_equal false
      expect(complete_movie.errors).must_include "title"
    end

    it "is invalid if overview is missing" do
      complete_movie.overview  = nil
      result = complete_movie.valid?
      result.must_equal false
      expect(complete_movie.errors).must_include "overview"
    end

    it "is invalid if release_date is missing" do
      complete_movie.release_date  = nil
      result = complete_movie.valid?
      result.must_equal false
      expect(complete_movie.errors).must_include "release_date"
    end

    it "is invalid if inventory is missing" do
      complete_movie.inventory  = nil
      result = complete_movie.valid?
      result.must_equal false
      expect(complete_movie.errors).must_include "inventory"
    end
  end

  describe "relations" do
    let(:movie) { movies(:romantic) }
    let(:customer) { customers(:cassy) }

    it "can have many customers" do

      movie.must_respond_to :customers


      movie.customers.each do |customer|
        customer.must_be_kind_of Customer
      end
    end

    it "has many rentals" do
      movie.must_respond_to :rentals
      movie.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end
  end

  describe "custom logic" do
    let(:movie) { movies(:romantic) }

    describe "available_inventory" do
      it "does not included checked in movies " do
        movie = Movie.create title: "What Dreams May Come",
          overview: "Very artsy movie",
          release_date: Date.today,
          inventory: 3

        # Creating "Checked in" rental. Should not be included in reduced inventory
        Rental.create checkout_date: (Date.today - 1),
         checkin_date: Date.today,
         due_date: Date.today + 6,
         movie_id: movie.id,
         customer_id: customers(:cassy).id

         expect(movie.available_inventory).must_equal 3
      end

      it "is reduced if a movie is not checked in" do
        movie = Movie.create title: "What Dreams May Come",
          overview: "Very artsy movie",
          release_date: Date.today,
          inventory: 3

        # Creating "Checked in" rental. Should not be included in reduced inventory
        Rental.create checkout_date: (Date.today - 1),
         checkin_date: nil,
         due_date: Date.today + 6,
         movie_id: movie.id,
         customer_id: customers(:cassy).id

         expect(movie.available_inventory).must_equal 2
      end
    end
  end
end
