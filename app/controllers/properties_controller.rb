class PropertiesController < ApplicationController

  def index
    @properties = Property.all
  end

  def new
    @property = Property.new
    @purpose = Purpose.all
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
    price_range = @property.price_ranges.where('(? between start_date and end_date)', Date.today).first
    unless price_range.nil?
      @property.daily_rate = price_range.daily_rate
    end
  end

  def edit
    @property = Property.find(params[:id])
    @purpose = Purpose.all
  end

  def update
    @property = Property.find(params[:id])
    @property.update(property_params)
    if @property.valid?
      redirect_to @property
    else
      render :edit
    end
  end

end



private

def property_params
  params.require(:property).permit(:title, :city, :state, :description, :maximum_guests, :daily_rate,
                 :property_type, :maximum_rent, :minimun_rent, :rules, :rent_purpose, :owner)
end
