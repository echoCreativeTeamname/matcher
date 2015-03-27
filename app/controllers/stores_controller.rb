class StoresController < ApplicationController

  def index
    @stores = Store.all.order(:city).includes(:chain)
  end

  def store
    @store = Store.find(params[:id])
  end

end
