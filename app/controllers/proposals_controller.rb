class ProposalsController < ApplicationController

  def new
    find_property
    @proposal = Proposal.new
  end

  def create
    find_property
    price_range = @property.price_ranges.where('(? between start_date and end_date)', Date.today).first
    unless price_range.nil?
      @property.daily_rate = price_range.daily_rate
    end
    @proposal = @property.proposals.create(proposal_params)
    if @proposal.valid?
      redirect_to @proposal
    else
      flash[:error] = 'Houve um erro ao tentar enviar a proposta'
      render :new
    end
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  private

  def find_property
    @property = Property.find(params[:property_id])
  end

  def proposal_params
    parameters = params.require(:proposal).permit(:start_date, :end_date, :total_guests, :name,
                  :email, :cpf, :phone, :observation)
  end

end
