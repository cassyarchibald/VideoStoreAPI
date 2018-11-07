require "test_helper"

describe MoviesController do
  describe "index" do
   it "is a real working route" do
     get movies_path
     must_respond_with :success
     expect(response.header['Content-Type']).must_include 'json'
  end
 end

  describe "show" do
    let(:id){movies(:funny).id}

    it "can retrieve a valid movie and returns JSON" do
      get movie_path(id)
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :success
    end

    it "returns a movie with valid keys" do
      get movie_path(id)
      body = JSON.parse(response.body)
      keys = %w(title overview release_date inventory available_inventory).sort
      expect(body["movie"].keys.sort).must_equal keys
    end

    it "returns status not found ok false for invalid ids" do
      invalid_id = -1
      get movie_path(invalid_id)
      must_respond_with :not_found
      body = JSON.parse(response.body)
      expect(body["ok"]).must_equal false
      expect(body["message"]).must_equal "not found"
    end
  end
end
