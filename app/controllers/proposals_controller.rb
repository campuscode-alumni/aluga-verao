class ProposalsController < ApplicationController

    def index
      @proposals = Proposal.where(accepted: false)
    end

    def show
      @proposal = Proposal.find(params[:id])
    end

   def accept_proposal

     @proposal = Proposal.find(params[:proposal_id])
     @proposal.accepted = true

    @proposal.save
     flash[:error] = 'Proposta aceita..'

     redirect_to proposals_url
   end
end
