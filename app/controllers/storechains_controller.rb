class StorechainsController < ApplicationController

  def index
    @storechains = Storechain.all
  end

  def storechain
    @storechain = Storechain.find(params[:id])
  end

end
