class MoviesController < ApplicationController
  def index
    movies = Movie.all.order(:title)
    render json: movies.as_json(only: [:id, :title, :release_date]), status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie.nil?
      render json: {ok: false, message: 'not found'},
      status: :not_found
    else
      render json: {
        title: movie.as_json(only: [:title])["title"],
        overview: movie.as_json(only: [:overview])["overview"],
        release_date: movie.as_json(only: [:release_date])["release_date"],
        inventory: movie.as_json(only: [:inventory])["inventory"],
        "available_inventory" => movie.available_inventory
        }, status: :ok
    end
  end

  def create
    movie = Movie.new(movie_params)

    if movie.save
      render json: {
        ok: true,
        id: movie.as_json(only: [:id])["id"]
      }, status: :ok

    else
      render json: {
        ok: false,
        message: movie.errors.messages
      }, status: :bad_request
    end
  end

  private

  def movie_params
    params.permit(:id, :title, :overview, :release_date, :inventory)
  end
end
