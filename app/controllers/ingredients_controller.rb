class IngredientsController < ApplicationController
  autocomplete :ingredient, :name, full: true

  def index
    @ingredients = Ingredient.all
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @ingredients.pluck(:name) }
    end
  end
end
