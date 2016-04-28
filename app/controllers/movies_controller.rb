class MoviesController < ApplicationController
  def index
    puts params
    movies = Movie.all
    if params[:commit] == "Submit"
      if params.has_key? :title
        movies = movies.by_titles(params[:title])
      end
      if params.has_key? :director
        movies = movies.by_directors(params[:director])
      end
      run_time = params[:run_time]  # Mason said this was better than using params[:run_time] in each if clause
      if run_time == '1'
        movies = movies.where("runtime_in_minutes < 90")
      elsif run_time == '2'
        movies = movies.where("runtime_in_minutes BETWEEN 90 AND 120")
      elsif run_time == '3'
        movies = movies.where("runtime_in_minutes > 120")
      end  
    end
    @movies = movies
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
