class ReviewsController < ApplicationController
  def new
    @property = Property.find params[:property_id]
    if @property.has_review_from? current_user
      flash[:alert] = 'Você já avaliou esse imóvel.'
      redirect_to my_rents_path
    else
      @property_review = @property.property_reviews.new
    end
  end

  def create
    @property = Property.find(params[:property_id])
    @property_review = @property.property_reviews.new(review_params)
    @property_review.user = current_user
    @property_review.save
    flash[:notice] = 'Avaliacao enviada com sucesso'
    redirect_to @property
  end

  private

  def review_params
    params.require(:property_review).permit(:rating, :comment)
  end

end
