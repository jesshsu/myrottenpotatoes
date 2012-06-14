class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #@movies = Movie.all
    @movies = Movie.find(:all, :order => (params[:sort_by]))
    if params[:ratings]
      @movies = Movie.where(:rating => params[:ratings].keys).find(:all, :order => (params[:sort_by]))
    end

    @sort_column = params[:sort_by]
    @all_ratings = Movie.all_ratings  #setting up @all_ratings variable by controller for Movie model
    @set_ratings = params[:ratings]
    if !@set_ratings
      @set_ratings = Hash.new
    end

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
