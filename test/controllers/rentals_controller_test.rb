require "test_helper"

describe RentalsController do
  describe 'check-out' do
    # Create for rental
    let(:movie) { movies(:funny) } #romantic_movie is being initialized as --> { movies(:romantic) }
    let(:customer) {customers(:shelan) }

    let (:rental_hash) do
      {
        rental: {
          checkout_date: Date.today,
          due_date: Date.today + 7,
          movie_id: movies(:scary).id,
          customer_id: customers(:cassy).id
        }
      }
    end


    it "should have a working route and returns JSON" do
      post checkout_path, params: rental_hash

      expect(response.header['Content-Type']).must_include 'json'

      must_respond_with :success

    end

    it "can create a new rental if given valid params" do
      expect {
        post checkout_path, params: rental_hash
      }.must_change 'Rental.count', 1

      expect(Rental.last.checkout_date).must_equal rental_hash[:rental][:checkout_date]
      expect(Rental.last.due_date).must_equal rental_hash[:rental][:due_date]
      expect(Rental.last.customer_id).must_equal rental_hash[:rental][:customer_id]
      expect(Rental.last.movie_id).must_equal rental_hash[:rental][:movie_id]

    end

    it "responds with an error for invalid params" do
      rental_hash[:rental][:customer_id] = nil

      expect {
        post checkout_path, params: rental_hash
      }.wont_change 'Rental.count'

      must_respond_with :bad_request

    end

    ###### PROBABLY REVISE THIS ########

    describe "available inventory" do

      it "Has an accurate available inventory after a rental is created" do
        movie = Movie.create(title: "test", overview: "test", release_date: Date.today, inventory: 3)

        start_count = movie.available_inventory

        rental_hash = {
          rental: {
            checkout_date: Date.today,
            due_date: Date.today + 7,
            movie_id: movie.id,
            customer_id: customers(:cassy).id
          }
        }

        # Do a post request for a rental that has that movie's id
        post checkout_path, params: rental_hash
        # Checking that available inventory was reduced

        expect(movie.available_inventory).must_equal start_count - 1
      end

      it "increases the number of movies the customer had checked out" do

        # Testing in rental controller as route will only run in this controller
        movie = Movie.create(title: "test", overview: "test", release_date: Date.today, inventory: 3)
        customer = customers(:cassy)
        # start_count = movie.customer.movies.length
        rental_hash = {
          rental: {
            checkout_date: Date.today,
            due_date: Date.today + 7,
            movie_id: movie.id,
            customer_id: customer.id
          }
        }

        start_count = customer.movies.length

        # Do a post request for a rental that has that movie's id
        post checkout_path, params: rental_hash
        # Checking that customer movies went up by one
        expect(customer.movies.length).must_equal start_count + 1

      end
    end

    it "Does not allow removal from an empty inventory" do
      # post check_out_path, params: rental_hash
      movie = Movie.create(title: "test", overview: "test", release_date: Date.today, inventory: 0)

      rental_hash = {
        rental: {
          checkout_date: Date.today,
          due_date: Date.today + 7,
          movie_id: movie.id,
          customer_id: customers(:cassy).id
        }
      }

      #Expect it will have errors
      # # # HOW # # #
      # Not sure how to test this
      post checkout_path, params: rental_hash




    end

    # it "adds one to the customer movies" do

    # end
  #
  #   it "has a check-out date set to today" do
  #     # post check_out_path, params: rental_hash
  #
  #
  #   end
  #
  #   it "has a due date set to a week from today" do
  #     # post check_out_path, params: rental_hash
  #
    end
  end
  # #
  # #   describe 'check-in' do
  # #
#   end
