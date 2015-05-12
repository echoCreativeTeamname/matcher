class IngredientsController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: [:new, :update]

  # GET /ingredients
  def index
    @ingredients = Ingredient.includes(:products, :recipes).all
  end

  # GET /ingredients/:id
  def ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  # POST /ingredients/:id/update
  def update
    @ingredient = Ingredient.find(params[:id])
    @ingredient.update(getIngredientParameters)
    redirect_to "/ingredients?edited=true"
  end

  # GET /ingredients/:id/delete
  def delete
    expire_fragment('current-matcher-status')

    Ingredient.find(params[:id]).destroy
    redirect_to "/ingredients?deleted=true"
  end

  # POST /ingredients/create
  def new
    expire_fragment('current-matcher-status')

    args = getIngredientParameters

    if(args[:name].to_s == "")
      redirect_to "/ingredients?save=false"
    else
      Ingredient.create(args)
      redirect_to "/ingredients?save=true"
    end
  end

  private
  def getIngredientParameters
    params.require(:ingredient).permit(:name, :healthclass, :imageurl)
  end

end
