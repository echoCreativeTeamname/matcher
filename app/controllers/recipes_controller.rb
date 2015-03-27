
class RecipesController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: [:new, :update]

	def index
		@recipes = Recipe.all
	end

	def recipe
		@recipe = Recipe.find(params[:id])
	end

	# POST /recipes/:id/update
  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(getRecipeParameters)
    redirect_to "/recipes?edited=true" 
  end

	# GET /recipes/:id/delete
  def delete
    Recipe.find(params[:id]).destroy
    redirect_to "/recipes?deleted=true"
  end

  private
  def getRecipeParameters
    params.require(:recipe).permit(:name, :contents, :imageurl, :videourl, :summary, :portions, :cookingtime, :dish_time)
  end
end