class CocktailsController < ApplicationController

  def index
    @cocktails = Cocktails.all
  end
  def new
    @cocktails = Cocktails.new
  end

  def create
    @cocktails = Cocktails.new(review_params)
    @cocktails.ingredients = Ingredients.find(params[:ingredients_id])
    @cocktails.save
  end
end
