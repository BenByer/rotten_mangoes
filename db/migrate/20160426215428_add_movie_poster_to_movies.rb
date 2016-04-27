class AddMoviePosterToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :image, :file
  end
end
