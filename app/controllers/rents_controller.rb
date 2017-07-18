class RentsController < ApplicationController
  
  def show
    @rent = Rent.find(params[:id])
  end

  def my_rents
    @rents = current_user.rents
  end
end
