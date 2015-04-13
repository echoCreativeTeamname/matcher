class MatchController < ApplicationController

	def index
		expire_fragment('current-matcher-status')

		@unmatchedIngredients = getUnmatchedIngredients
		@ingredientCount = @unmatchedIngredients.size

		@unmatchedRecipes = getUnmatchedRecipes
		@recipeCount = @unmatchedRecipes.size
	end

	def ingredients
		expire_fragment('current-matcher-status')

		unmatchedIngredients = getUnmatchedIngredients
		unless(unmatchedIngredients.empty?)
			redirect_to "/match/ingredients/0"
		else
			redirect_to "/match"
		end
	end

	# /match/recipes
	def recipes
		expire_fragment('current-matcher-status')

		unmatchedRecipes = getUnmatchedRecipes
		unless(unmatchedRecipes.empty?)
			redirect_to "/match/recipes/#{unmatchedRecipes[0].id}"
		else
			redirect_to "/match"
		end
	end

	# /match/ingredients/:id
	def ingredient
		unmatchedIngredients = getUnmatchedIngredients
		if(@ingredient = unmatchedIngredients.fetch(params[:id].to_i, false))
			@i = params[:id].to_i
			@storechain_data = Storechain.all.as_json.map do |storechain|
				ingredient = @ingredient.products.find_by(storechain: storechain["id"]);
				storechain["product"] = ingredient ? ingredient.as_json : nil
				storechain
			end
		else
			redirect_to "/match/ingredients"
		end
	end

	# /match/recipes/:recipes_id
	def recipe

	end

	# /match/products/find?[name,chain_id]
	def find_products
		@products = Product.where(Product.arel_table[:name].matches("%#{params[:name]}%")).where(storechain_id: params[:chain_id]).all
		render :layout => false
	end

	# /match/ingredients/find
	def find_ingredients
		@ingredients = Ingredient.where(Ingredient.arel_table[:name].matches("%#{params[:name]}%")).all
		render :layout => false
	end
end
