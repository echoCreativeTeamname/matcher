class ApplicationController < ActionController::Base
  layout "application"
  protect_from_forgery with: :exception

  def index
    expire_fragment('current-matcher-status')
  end

  def getMenu

    menu = {
      "stores" => {name: "winkels", url: "/stores"},
      "storechains" => {name: "winkelketens", url: "/storechains"},
      "recipes" => {name: "recepten", url: "/recipes"},
      "ingredients" => {name: "ingrediënten", url: "/ingredients"},
      "match" => {name: "match", url: "/match"}
    }

    if(menu[controller_name])
      menu[controller_name][:current] = true;
    end

    return menu;

  end

  def getMatcherStatus
    if(getUnmatchedRecipes.empty? == false)
      return '<a href="/match" class="badge" style="background-color: #d9534f;">actie noodzakelijk</a>'
    elsif(getUnmatchedIngredients.empty? == false)
      return '<a href="/match" class="badge" style="background-color: #f0ad4e;">actie nodig</a>'
    else
      return '<a href="/match" class="badge" style="background-color: #5cb85c;">up-to-date</a>'
    end
  end

  private
  def getUnmatchedIngredients
    chainCount = Storechain.all.size
    unmatchedIngredients = []
    Ingredient.includes(:products, :recipeingredients).all.each do |ing|
      if ing.products.size < chainCount
        unmatchedIngredients << ing
      end
    end
    return unmatchedIngredients;
  end

  def getUnmatchedRecipes
    return UnmatchedRecipe.all
  end
end
