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
    let(:movie) { movies(:romantic) } #romantic_movie is being initialized as --> { movies(:romantic) }
    let(:customer) {customers(:cassy) }

    it "has many customers through rental" do
      #Act
      movie.customers << customer #add 1st customer to a movie's customer
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
  end
end
