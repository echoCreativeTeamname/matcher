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

		@recipeCount = 0
		@unmatchedRecipes = []
	end

	def ingredients
		#Product.where(Product.arel_table[:name].matches('%biologische koffie%')).first.price.to_f
	end

	# /match/products/find?[name,chain_id]
	def find_product

	end

	# /match/recipes
	def recipes

	end

	# /match/recipes/:recipes_id
	def recipe

	end

	# /match/ingredients/find
	def find_ingredient

	end


end