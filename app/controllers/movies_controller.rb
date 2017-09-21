class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    
    #comment
    
    @movies = Movie.all
    
    if(params.has_key?(:sort) && !params.has_key?(:commit))
      if params[:sort] == "title"
        @movies = Movie.all.order(:title => "ASC")
    
      elsif params[:sort] == "release_date"
        @movies = Movie.all.order(:release_date => "DESC") 
    
      else
          @movies = Movie.all
      end
    end
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  helper_method :find_class
  
  def find_class(header)
    params[:sort] == header ? 'hilite' : nil
  end

end
