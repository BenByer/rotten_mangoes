class MoviesController < ApplicationController
  def index
    some_movies = Movie.all
    if params.has_key? :title
      some_movies = some_movies.where("title LIKE '%#{params[:title]}%'")
    end
    if params.has_key? :director
      some_movies = some_movies.where("director LIKE '%#{params[:director]}%'")
    end
    run_time = params[:run_time]
    if run_time == '1'
      some_movies = some_movies.where("runtime_in_minutes < 90")
    elsif run_time == '2'
      some_movies = some_movies.where("runtime_in_minutes BETWEEN 90 AND 120")
    elsif run_time == '3'
      some_movies = some_movies.where("runtime_in_minutes > 120")
    end  
    @movies = some_movies
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path 
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :image, :description
    )
  end
end
