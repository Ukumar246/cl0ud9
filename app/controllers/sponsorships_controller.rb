class SponsorshipsController < ApplicationController

  def new
    #Partial
  end

  def create
    params.permit!
    @sponsorship = Sponsorship.new(params[:sponsorship])

    if @sponsorship.save
      # flash.now for to make the flash disappear after a while
      flash[:success] = 'You have sucessfully created Sponsorship.'
    else
      # TODO:need to display specific errors
      flash[:danger] = @sponsorship.errors.full_messages
    end

    @sponsorship2 = Sponsorship.find(params[:sponsorship])
    redirect_to :controller => 'tournaments' , :action => 'organize' , :id => @sponsorship2.tournament_id
    #redirect_to Tournament.find(params[:sponsorship][:tournament_id])
    #@tournament =  @sponsorship.tournament_id
    #redirect_to :action => 'organize', :id => @tournament

  end

  private
  def sponsorship_params
    params.require(:sponsorship).permit(:name, :price, :description, :tournament_id)
  end

end
