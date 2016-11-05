class SponsorsController < ApplicationController
  def new
    #Partial
  end

  def create
    params.permit!

    @sponsor = Sponsor.new(params[:sponsor])
    if @sponsor.save
      # flash.now for to make the flash disappear after a while
      flash[:success] = 'You have sucessfully sponsored this tournament.'
    else
      # TODO:need to display te specific errors
      flash[:danger] = @sponsor.errors.full_messages
    end
    redirect_to Tournament.find(params[:sponsor][:tournament_id])    
  end
end
