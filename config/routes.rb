Rails.application.routes.draw do

  root 'application#index'

  get 'stores' => 'stores#index'
  get 'stores/:id' => 'stores#store'

  get 'storechains' => 'storechains#index'
  get 'storechains/:id' => 'storechains#storechain'

  get 'ingredients' => 'ingredients#index'
  post 'ingredients/create' => 'ingredients#new'
  get 'ingredients/:id' => 'ingredients#ingredient'
  get 'ingredients/:id/delete' => 'ingredients#delete'
  post 'ingredients/:id/update' => 'ingredients#update'

  get 'recipes' => 'recipes#index'
  get 'recipes/new' => 'recipes#create'
  get 'recipes/calc' => 'recipes#calc_cost'
  get 'recipes/:id' => 'recipes#recipe'
  post 'recipes/:id/update' => 'recipes#update'
  get 'recipes/:id/delete' => 'recipes#delete'
  post 'recipes/:id/add_ingredient' => 'recipes#add_ingredient'
  get 'recipes/:id/delete_ingredient/:ingredient_id' => 'recipes#delete_ingredient'

  get 'match' => 'match#index'
  get 'match/ingredients' => 'match#ingredients'
  get 'match/ingredients/find' => 'match#find_ingredients'
  get 'match/ingredients/:id/save' => 'match#save_ingredient'
  get 'match/ingredients/:id' => 'match#ingredient'
  get 'match/recipes' => 'match#recipes'
  get 'match/recipes/:id' => 'match#recipe'
  get 'match/products/find' => 'match#find_products'


end
