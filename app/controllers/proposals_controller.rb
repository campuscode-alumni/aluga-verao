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
    parameters = params.require(:proposal).permit(:start_date, :end_date, :total_guests, :name,
                  :email, :cpf, :phone, :observation)
    parameters[:total_amount] = calculate_total_amount @property
    parameters
  end

  def calculate_total_amount(property)
    end_date = params[:proposal][:end_date]
    start_date = params[:proposal][:start_date]
    days = (end_date.to_time - start_date.to_time) / (24 * 60 * 60)

    (property.daily_rate * days.to_i).to_f
  end

end
