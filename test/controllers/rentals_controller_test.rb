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
#
#   it "Removes one from the movies inventory" do
#     # post check_out_path, params: rental_hash
#
#
#   end
#
#   it "Does not allow removal from an empty inventory" do
#     # post check_out_path, params: rental_hash
#
#
#   end
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
#   end
end
#
#   describe 'check-in' do
#
#   end
end
