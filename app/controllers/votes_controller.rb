class VotesController < ApplicationController
  before_filter :require_user
  before_filter :fetch_refactor
  
  def create
    unless current_user.votes.include?(@refactor)
      @vote = Vote.new(params[:vote])
      @vote.user = current_user
      @vote.refactor = @refactor
      if @vote.save
        expire_fragment("refactor_votes_#{@refactor.id}")
        render :text => 'success'
      else
        render :text => 'fail'
      end
    end
  end
  
  private
  
    def fetch_refactor
      @refactor = Refactor.find(params[:refactor_id])
    end
end