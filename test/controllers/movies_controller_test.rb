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
      keys = %w(title overview Date.parse(release_date) inventory available_inventory).sort
      expect(keys.sort).must_equal keys
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
    let(:movie_hash) do
      {
          title: "A great movie",
          overview: "The world ends",
          release_date: "2010-11-05",
          inventory: 2
        }
    end
    it "can creates a new movie given valid params" do
      #Act
      expect {
        post movies_path, params: movie_hash
      }.must_change 'Movie.count', 1

      expect(Movie.last.title).must_equal movie_hash[:title]
      expect(Movie.last.overview).must_equal movie_hash[:overview]
      expect(Movie.last.release_date).must_equal Date.parse(movie_hash[:release_date])
      expect(Movie.last.inventory).must_equal movie_hash[:inventory]
    end

    it "responds with an error for invalid movie params" do
      movie_hash[:title] = nil

        expect {
          post movies_path, params: movie_hash
        }.wont_change 'Movie.count'

        must_respond_with :bad_request
      end
    end
  end
