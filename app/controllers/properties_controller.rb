class PropertiesController < ApplicationController
  def filtered
    @filter = params[:filter]
    @properties = []
    unless @filter.strip.empty?
      @properties =  Property.where('city = ?', @filter)
    end
  end

  def show
    @property = Property.find(params[:id])
  end
end
