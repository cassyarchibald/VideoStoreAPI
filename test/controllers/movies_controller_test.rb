require "test_helper"

describe MoviesController do

  describe "show" do

    it "can retrieve a valid movie and returns JSON" do
      get movie_path(Movie.first.id)
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :success
    end

    it "returns a movie with valid keys" do
      get movie_path(Movie.first.id)
      body = JSON.parse(response.body)
      keys = %w(title overview release_date inventory available_inventory).sort
      expect(body["movie"].keys.sort).must_equal keys
    end

    it "returns status not found ok false for invalid ids" do
      id = -1
      get movie_path(id)
      must_respond_with :not_found
      body = JSON.parse(response.body)
      expect(body["ok"]).must_equal false
      expect(body["message"]).must_equal "not found"
    end

  end


end
