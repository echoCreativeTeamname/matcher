class ApplicationController < ActionController::Base
  layout "application"
  protect_from_forgery with: :exception

  def getMenu

    menu = {
      "stores" => {name: "winkels", url: "/stores"},
      "storechains" => {name: "winkelketens", url: "/storechains"},
      "recipes" => {name: "recepten", url: "/recipes"},
      "ingredients" => {name: "ingrediënten", url: "/ingredients"},
    }

    if(menu[controller_name])
      menu[controller_name][:current] = true;
    end

    return menu;
  end
end
