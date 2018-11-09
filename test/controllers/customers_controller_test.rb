require "test_helper"

describe CustomersController do

  describe "index" do
    before do
      get customers_path
    end

    it "should get index as a real working route and returns JSON" do
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :success
    end

    it "returns an array of all customers" do
      body = JSON.parse(response.body)

      # Assert
      expect(body).must_be_kind_of Array
      expect(body.length).must_equal Customer.count

    end

    it "returns customers with exactly the required fields" do
      keys = %w(id name registered_at postal_code phone movies_checked_out_count).sort
      body = JSON.parse(response.body)

      body.each do |customer|
        expect(customer.keys.sort).must_equal keys
        expect(customer.keys.length).must_equal keys.length
      end
    end
  end
end
