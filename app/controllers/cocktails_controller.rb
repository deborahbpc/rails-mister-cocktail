class CocktailsController < ApplicationController
  before_action :set_cocktail, only: [:show]

  def index
    @search = params['search']
    if @search.present? && @search != ''
      @name = @search["name"]
      @cocktails = Cocktail.where("name ILIKE ?", "%#{@name}%")
    else
      @cocktails = Cocktail.all
    end
  end

  def show
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)

    if @cocktail.save
      redirect_to @cocktail, notice: 'Cocktail has been successfully created!'
    else
      render :new
    end
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :description, :photo)
  end

  def search_params
    params.require(:search).permit(:name)
  end
end
