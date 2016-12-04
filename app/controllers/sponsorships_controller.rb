class SponsorshipsController < ApplicationController

  def new
    #Partial
  end

  def create
    params.permit!
    @sponsorship = Sponsorship.new(params[:sponsorship])

    if @sponsorship.save
      flash[:success] = 'You have sucessfully created a sponsorship.'
      @success = true

    else
      # TODO:need to display specific errors
      flash[:danger] = @sponsorship.errors.full_messages

    end

    redirect_to :controller => 'tournaments' , :action => 'organize' , :id => params[:sponsorship][:tournament_id]

  end

  private
  def sponsorship_params
    params.require(:sponsorship).permit(:name, :price, :description, :tournament_id)
  end

end
