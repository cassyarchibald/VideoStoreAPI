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

    it 'cannot rent out a movie if available inventory is greater than 1' do
      movie = Movie.create(title: "test", overview: "test", release_date: Date.today, inventory: 0)
      rental = Rental.new(movie_id: movie.id, customer_id: Customer.first.id)
      result = rental.valid?
      binding.pry
      result.must_equal false
      expect(rental.errors.messages[:available_inventory_of_movie][0]).must_include "Must be greater than 0"
    end

    it 'can rent out a movie if available inventory is greater than 0' do
      movie = Movie.new(title: "test", overview: "test", release_date: Date.today, inventory: 2)
      result = movie.valid?
      result.must_equal true
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

  describe "custom logic" do
    # Logic for movie available inventory
    # will live in rental controller test
    # as that happens only after a rental post request

    it "has a checkout_date equal to the  date created" do
      # Need to remove attribute availabe inventory
      rental = Rental.new movie_id: movies(:funny).id,
        customer_id: customers(:cassy).id

      rental.save

      expect(rental.checkout_date).must_equal rental.created_at.to_date

    end

    it "has a due date equal to a week after the checkout date" do
      # Need to remove attribute availabe inventory
      rental = Rental.new movie_id: movies(:funny).id,
        customer_id: customers(:cassy).id

      rental.save

      expect(rental.due_date).must_equal rental.checkout_date + 7

    end
  end
end
