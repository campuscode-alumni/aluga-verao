class PropertyTypesController < ApplicationController
  def show
    @property_type = PropertyType.find(params[:id])
  end

  def new
    @property_type = PropertyType.new
  end

  def create
    @property_type = PropertyType.create property_type_params
    if @property_type.valid?
    redirect_to @property_type
    else
    flash[:error] = 'Houve um erro'
    render :new
    end
  end

  private

  def property_type_params
    params.require(:property_type).permit(:name)
  end

end
