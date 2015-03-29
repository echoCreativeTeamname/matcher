
class RecipesController < ApplicationController

  skip_before_filter :verify_authenticity_token

  # GET /recipes
	def index
		@recipes = Recipe.all
	end

  # GET /recipes/create
  def create
    recipe = Recipe.create()
    redirect_to "/recipes/#{recipe.id}"
  end

  # GET /recipes/:id
	def recipe
		@recipe = Recipe.find(params[:id])
	end

	# POST /recipes/:id/update
  def update
    recipe = Recipe.find(params[:id])
    recipe.update(getRecipeParameters)
    redirect_to "/recipes/#{params[:id]}?edited=true"
  end

  # GET /recipes/:id/delete_ingredient/:ingredient_id
  def delete_ingredient
    ingredient = Recipeingredient.find_by(recipe_id: params[:id], ingredient_id: params[:ingredient_id])

    ingredient.destroy

    if(params[:ajax] == true)
      render json: {deleted: true}
    else
      redirect_to "/recipes/#{params[:id]}?ingredient_deleted=true"
    end
  end

  # POST /recipes/:id/add_ingredient
  def add_ingredient
    @ingredient = Ingredient.find(params[:ingredient_id])
    @recipe = Recipe.find(params[:id])
    @recipe.recipeingredients.create(ingredient: @ingredient, amount: params[:amount])

    if(params[:ajax] == true)
      render json: {created: true}
    else
      redirect_to "/recipes/#{params[:id]}?ingredient_created=true"
    end
  end

	# GET /recipes/:id/delete
  def delete
    Recipe.find(params[:id]).destroy
    redirect_to "/recipes?deleted=true"
  end

  private
  def getRecipeParameters
    params.require(:recipe).permit(:name, :contents, :imageurl, :videourl, :summary, :portions, :cookingtime, :dish_type)
  end
end
