class PropertiesController < ApplicationController

  def filtered_properties
    @filter = params[:filter]
    @properties = []
    unless @filter.strip.empty?
      @properties =  Property.where('city = ?', @filter)
    end
  end

end
