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

    date = Date.parse( "#{params[:date][:year]}/#{params[:date][:month]}/#{params[:date][:day]}")

    @properties = []
    unless @filter.strip.empty?

      # properties_ids = Proposal.all.where('start_date >= ?', date ).where('end_date <= ?', date).pluck(:property_id)

      properties_id = Proposal.all.where(accepted: false).pluck(:property_id)
      puts properties_id
      @properties =  Property.all.where('city = ?', @filter).where(id: properties_id )


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
