require "test_helper"

describe RentalsController do
  describe 'check-out' do
    #
    let(:movie) { movies(:funny) }
    let(:customer) {customers(:shelan) }

    let (:rental_hash) do
      {
        rental: {
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

      rental_hash = {
        rental: {
          movie_id: movies(:funny).id,
          customer_id: customers(:cassy).id
        }
      }

      post checkout_path, params: rental_hash

      # Finding rental with information that is the same
        # As our post request.
        # Wasn't sure how else to do this as we don't have an
        # id in the post request
      rental = Rental.find_by( movie_id: movies(:funny).id, customer_id: customers(:cassy).id, due_date: Date.today + 7, checkout_date: Date.today  )

      expect(rental.checkout_date).must_equal Date.today
      expect(rental.due_date).must_equal Date.today + 7
    end

    it "responds with an error for invalid params" do
      rental_hash[:rental][:customer_id] = nil

      expect {
        post checkout_path, params: rental_hash
      }.wont_change 'Rental.count'

      must_respond_with :bad_request
    end

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

        post checkout_path, params: rental_hash

        expect(movie.available_inventory).must_equal start_count - 1
      end

      it "increases the number of movies the customer had checked out" do

        movie = Movie.create(title: "test", overview: "test", release_date: Date.today, inventory: 3)
        customer = customers(:cassy)

        rental_hash = {
          rental: {
            checkout_date: Date.today,
            due_date: Date.today + 7,
            movie_id: movie.id,
            customer_id: customer.id
          }
        }

        start_count = customer.movies_checked_out_count

        # Do a post request for a rental that has that movie's id
        post checkout_path, params: rental_hash

        # Checking that customer movies went up by one
        expect(customer.movies_checked_out_count).must_equal start_count + 1
      end
    end
  end

  describe 'check-in' do
    let(:rental) {rentals(:check_out_rental)}

    it 'sets the check-in date to today' do

      rental_hash = {
        rental: {
          movie_id: rental.movie.id,
          customer_id: rental.customer.id
        }
      }

      post checkin_path, params: rental_hash

      rental.reload
      expect(rental.checkin_date).must_equal Date.today
    end
  end
end
