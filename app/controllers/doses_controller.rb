class DosesController < ApplicationController
  before_action :set_dose, only: [:show, :edit, :update, :destroy]

  def index
    @doses = Dose.all
  end

  def show
  end

  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
    @ingredients = Ingredient.names
  end

  def edit
  end

  def create
    @dose = Dose.new(dose_params)
    @dose.ingredient = Ingredient.find_by(name: params[:dose][:ingredient])
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose.cocktail_id = @cocktail.id
    if @dose.save
      redirect_to cocktail_path(@dose.cocktail_id), notice: 'Dose was successfully created.'
    else
      flash[:alert] = 'Invalid dose.'
      render 'cocktails/show'
    end
  end

  def update
    if @dose.update(dose_params)
      redirect_to @dose, notice: 'Dose was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @dose.destroy
    redirect_to cocktail_path(@dose), notice: 'Dose was successfully destroyed.'
  end

  private
    def set_dose
      @dose = Dose.find(params[:id])
    end

    def dose_params
      # params[:dose][:ingredient_id] = params[:dose][:ingredient].to_i
      params.require(:dose).permit(:description)
    end
end
