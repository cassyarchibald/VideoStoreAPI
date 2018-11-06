class MoviesController < ApplicationController












  def show
    movie = Movie.find_by(id: params[:id])

    if movie.nil?
      render json: {
        ok: false,
        message: 'not found' },
      status: :not_found
    else
      render json: {
        ok: true,
        movie: movie.as_json(only: [:title, :overview, :release_date, :inventory, :available_inventory ]), status: :ok
      }
    end
  end
end
