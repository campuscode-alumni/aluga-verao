class PropertiesController < ApplicationController
  before_action :set_collection, only: [:new, :create, :edit, :update]

  def index
    @properties = Property.all
  end

  def new
    @property = Property.new
    @purposes = Purpose.all
  end

  def create
    @property = Property.new(property_params)
    @property.owner = current_user
    if @property.save
      redirect_to @property
    else
      flash[:error] = 'Este imovel nao pode ser cadastrado sem um proprietario'
      @property = Property.new
      @purposes = Purpose.all
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
    @purposes = Purpose.all
  end

  def update
    @property = Property.find(params[:id])
    @property.update(property_params)
    if @property.valid?
      redirect_to @property
    else
      @purposes = Purpose.all
      render :edit
    end
  end

  private

  def set_collection
    @property_types = PropertyType.all
  end

  def property_params
    params.require(:property).permit(:title, :city, :state, :description, :maximum_guests, :daily_rate,
                  :property_type_id, :maximum_rent, :minimun_rent, :rules, :owner, :photo, purpose_ids:[])
  end

end
