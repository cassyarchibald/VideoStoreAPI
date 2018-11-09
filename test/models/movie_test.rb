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
  end # Validation end

  describe "relations" do
    let(:movie) { movies(:romantic) } #romantic_movie is being initialized as --> { movies(:romantic) }
    let(:customer) { customers(:cassy) }

    it "has many customers through rental" do
      #Act
      
      movie.rentals.customers << customer #add 1st customer to a movie's customer
      customers = movie.customers #customers = movie's customers

      #assert
      expect(customers.length).must_be :>=, 1 #customers length should change by 1
      customers.each do |customer|
        expect(customer).must_be_instance_of Customer
      end
    end

    it "has many rentals" do
      movie.must_respond_to :rentals
      movie.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end
  end # End of relations

  describe "custom logic" do
    let(:movie) { movies(:romantic) } #romantic_movie is being initialized as --> { movies(:romantic) }
    # Remove -
      # Should be testing that after a rent
        # post the available_inventory returned
        # in the body keys is correct
    # describe "reduce inventory" do
    #   it "Reduces inventory by one if there is at least one item in inventory" do
    #     start_inventory_count = movie.inventory
    #     movie.reduce_inventory
    #     expect(movie.inventory).must_equal start_inventory_count - 1
    #   end
    #
    #   it "Returns false if inventory is 0" do
    #     movie.inventory = 0
    #     expect(movie.reduce_inventory).must_equal false
    #   end
    # end # End of reduce inventory


    describe "number of checked out movies" do
      it "returns the number of movies that are currently checked out" do
        movie = movies(:funny)
        expect(movie.number_of_checked_out_movies).must_equal Rental.where(movie_id: movie.id).length
      end
    end

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
