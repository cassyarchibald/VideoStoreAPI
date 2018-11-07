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

  describe "create" do
    let (:movie_params) do
      {
        movie: {
          title: 'Blue Day',
          overview: 'A great movie',
          release_date: '1948-03-31',
          inventory: 2
        }
      }
    end

    it "can creates a new movie given valid params" do
      #Act
      expect {
        post movies_path, params: movie_params
      }.must_change 'Movie.count', 1

      expect(Movie.title).must_equal movie_params[:movie][:title]
      expect(Movie.overview).must_equal movie_param[:movie][:overview]
      expect(Movie.release_date).must_equal book_hash[:movie][:release_date]
    end

    it "responds with an error for invalid movie params" do
      movie_params[:movie][:title] = nil

      expect {
        post movies_path, params: movie_params
      }.wont_change 'Movie.count'

      must_respond_with :bad_request
    end
  end
end
