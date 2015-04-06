class MatchController < ApplicationController

	def index
		@chainCount = Storechain.all.size

		# ingredient count
		@ingredientCount = 0
		@unmatchedIngredients = []
		Ingredient.all.includes(:products, :recipeingredients).each do |ing|
			if ing.products.size < @chainCount
				@ingredientCount += 1
				@unmatchedIngredients << ing
			end
		end

		@recipeCount = 1
		@unmatchedRecipes = []
	end

	def ingredients

	end



	# /match/recipes
	def recipes

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
