class ProposalsController < ApplicationController

  def index
    @proposals = Proposal.all.where(accepted: false)
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  def new
    find_property
    @proposal = @property.proposals.new
  end

  def create
    find_property

    price_range = @property.price_ranges.where('(? between start_date and end_date)', Date.today).first
    unless price_range.nil?
      @property.daily_rate = price_range.daily_rate
    end

    @proposal = @property.proposals.new(proposal_params)
    @proposal.user = current_user
    if @property.is_available?( @proposal.start_date, @proposal.end_date )
      if @proposal.save
        redirect_to @proposal
      else
        flash[:error] = 'Houve um erro ao tentar enviar a proposta'
        render :new
      end
    else
      flash[:error] = 'casa indisponivel'
      render :new
    end
  end

  def accept_proposal
    @proposal = Proposal.find(params[:proposal_id])
    @proposal.accepted = true

    @proposal.save
    flash[:notice] = 'Proposta aceita..'

    rent = Rent.create( proposal: @proposal )
    redirect_to rent_url(rent)
  end

  def my_proposals
    @proposals = Proposal.where(user: current_user)
  end

  def print_cupom
    @proposal = Proposal.find(params[:proposal_id])
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
