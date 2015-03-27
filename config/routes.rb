Rails.application.routes.draw do

  root 'application#index'

  get 'stores' => 'stores#index'
  get 'stores/:id' => 'stores#store'

  get 'ingredients' => 'ingredients#index'
  post 'ingredients/create' => 'ingredients#new'
  get 'ingredients/:id' => 'ingredients#ingredient'
  get 'ingredients/:id/delete' => 'ingredients#delete'
  post 'ingredients/:id/update' => 'ingredients#update'

  get 'recipes' => 'recipes#index'
  get 'recipes/:id' => 'recipes#recipe'
  post 'recipes/:id/update' => 'recipes#update'
  get 'recipes/:id/delete' => 'recipes#delete'
end
