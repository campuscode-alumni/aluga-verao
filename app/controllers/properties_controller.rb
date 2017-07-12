class PropertiesController < ApplicationController


  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      redirect_to @property
    else
      flash[:error] = 'Este imovel nao pode ser cadastrado sem um proprietario'
      @property = Property.new
      render :new
    end
  end

  def filtered
    @filter = params[:filter]
    @properties = []
    unless @filter.strip.empty?
      @properties =  Property.all.where('city = ?', @filter)
    end
  end

  def show
    @property = Property.find(params[:id])
  end
end

private

def property_params
  params.require(:property).permit(:city, :state, :description, :maximum_guests, :daily_rate,
                 :property_type, :maximum_rent, :minimun_rent, :rules, :rent_purpose, :owner)
end
