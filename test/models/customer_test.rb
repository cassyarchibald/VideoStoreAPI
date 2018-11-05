require "test_helper"

describe Customer do
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
    end

    it "is invalid if registered_at is missing" do

    end

    it "is invalid if address is missing" do

    end

    it "is invalid if city is missing" do

    end

    it "is invalid if state is missing" do

    end

    it "is invalid if postal code is missing" do

    end

    it "is invalid if phone is missing" do

    end


    it "is invalid if missing a field" do

    end
  end

  describe "relationships" do

    it "has many movies through rentals" do

    end
  end
end
