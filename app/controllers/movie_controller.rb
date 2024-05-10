class MovieController < ApplicationController

  def index
    @movie = Omdb::V1::Client.new.movie(params[:query])
    render json: @movie
  end

end
