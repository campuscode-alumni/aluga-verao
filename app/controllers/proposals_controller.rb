class ProposalsController < ApplicationController

    def index
      @proposals = Proposal.where(accepted: false)
    end

    def show
      @proposal = Proposal.find(params[:id])
    end

    def new
      @property = Property.find(params[:property_id])
      @proposal = @property.proposals.new
    end

    def create
      @property = Property.find(params[:property_id])
      @proposal = @property.proposals.new

      if @property.is_available?( params[:proposal][:start_date], params[:proposal][:end_date] )
          flash[:error] = 'casa OK'
        redirect_to @proposal
      else
        flash[:error] = 'casa indisponivel'
        render :new
      end
    end

   def accept_proposal

     @proposal = Proposal.find(params[:proposal_id])
     @proposal.accepted = true

    @proposal.save
     flash[:error] = 'Proposta aceita..'

     redirect_to proposals_url
   end
end
