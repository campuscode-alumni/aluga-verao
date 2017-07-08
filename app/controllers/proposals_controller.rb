class ProposalsController < ApplicationController

  def new
    find_property
    @proposal = Proposal.new
  end

  def create
    find_property
    @proposal = @property.proposal.create(proposal_params)

    redirect_to @proposal
  end

  def show
    
  end

  private

  def find_property
    @property = Property.find(params[:property_id])
  end

  def proposal_params
    params.require(:proposal).permit(:start_date, :end_date, :total_guests, :name,
                  :email, :cpf, :phone, :observation)
  end

end
