require 'open-uri'

Dose.destroy_all

Ingredient.destroy_all
Cocktail.destroy_all

BASE_URL = "http://www.thecocktaildb.com/api/json/v1/1/"

def create_new_cocktail(cocktail_h)
  new_cocktail = {
    name:       cocktail_h['strDrink'],
    category:  cocktail_h['strAlcoholic'],
    alcoholic:  cocktail_h['strAlcoholic'] == 'Alcoholic',
    glass_type: cocktail_h['strGlass'],
    # image_url:  cocktail_h['strDrinkThumb'],
    instructions: cocktail_h['strInstructions']
  }

  cocktail = Cocktail.create(new_cocktail)
  if cocktail.valid?
    puts "cocktail #{cocktail.name} successfully created"
    # add doses to cocktail
    (1..15).each do |i|
      dose = Dose.new
      dose.cocktail = cocktail
      dose.description = cocktail_h['strMeasure' + i.to_s]
      break if dose.description.nil? || dose.description.empty?
      dose.ingredient = Ingredient.find_by(name: cocktail_h['strIngredient' + i.to_s])
      dose.save
    end
  else
    puts "unable to create cocktail #{cocktail_h}"
  end
  # retrieve image and upload it to cloudinary
  url = cocktail_h['strDrinkThumb']
  begin
    cocktail.photo_url = url unless url.nil?
    puts "image #{url} successfully added"
  rescue
    cocktail.photo_url = "http://www.bistrot.fr/wp-content/uploads/2015/07/Spritz.jpg"
  end
end

def scrap_cocktail_detail(cocktails)

  cocktails.each do |cocktail|
    cocktail_h = JSON.load(open(BASE_URL + 'lookup.php?i=' + cocktail["idDrink"]))['drinks'].first
    create_new_cocktail(cocktail_h)
  end
end

def scrap_ingredients
  # http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list
  ingredients = JSON.load(open(BASE_URL + "list.php?i=list"))['drinks']

  ingredients.each do |ingredient|
    Ingredient.create(name: ingredient['strIngredient1'])
  end
end

scrap_ingredients
scrap_cocktail_detail(JSON.load(open(BASE_URL + "filter.php?c=Cocktail"))['drinks'].first(10))
scrap_cocktail_detail(JSON.load(open(BASE_URL + "filter.php?c=Ordinary_Drink"))['drinks'].first(10))
