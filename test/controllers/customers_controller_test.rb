require "test_helper"

describe CustomersController do
  describe "index" do

    it "is a real working route and returns JSON" do
      get customers_path

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Array 

    end

    it "returns an array" do

    end

    it "returns all customers" do

    end

    it "returns customres with exactly the required fields" do

    end

  end
end
