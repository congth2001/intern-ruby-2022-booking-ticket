class Admin::MoviesController < AdminController
  def index
    @pagy, @movies = pagy Movie.sort_list.all,
                          items: Settings.digits.admin_movie_per_page
  end

  def show
    @movie = Movie.find_by id: params[:id]
    return if @movie

    flash[:danger] = t "film_not_found"
    redirect_to admin_root_path
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new movie_params

    if @movie.save
      flash[:success] = t "updated"
      redirect_to admin_movie_path(id: @movie.id)
    else
      flash[:danger] = t "not_updated"
      redirect_to admin_movies_path
    end
  end

  def edit
    @movie = Movie.find_by id: params[:id]
  end

  def update
    @movie = Movie.find_by id: params[:id]
    if @movie.update movie_params 
      flash[:success] = "Changed"
      redirect_to admin_movie_path(id: @movie.id)
    else
      flash[:danger] = "Not changed"
      render :edit
    end
  end

  def destroy
    Movie.find_by(id: params[:id]).destroy
    flash[:success] = t "deleted"
    redirect_to request.referrer || admin_root_url
  end

  private

  def movie_params
    params.require(:movie).permit(%i(title description img_link
      duration_min release_time language
      director cast age_range category_id).freeze)
  end
end
