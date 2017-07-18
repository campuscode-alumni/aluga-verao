class ReviewsController < ApplicationController
  def new
      @property = Property.find(params[:property_id])
      @property_review = @property.property_reviews.new
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
