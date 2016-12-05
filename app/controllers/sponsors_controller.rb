class SponsorsController < ApplicationController
  #before_action :require_payment

  def new
    #Partial
  end

  def create
    params.permit!

    @sponsor = Sponsor.new(params[:sponsor])
    @sponsor.paid = false

    if @sponsor.save
      # flash.now for to make the flash disappear after a while
      flash[:success] = 'You have sucessfully sponsored this tournament.'
    else
      # TODO:need to display te specific errors
      flash[:danger] = @sponsor.errors.full_messages
    end
    #redirect_to Tournament.find(params[:sponsor][:tournament_id]) and return
    redirect_to url_for(:controller => :charges , :action => :new,:sponsor_id => @sponsor.id,:sponsorship_id => @sponsor.sponsorship_id) and return
  end

  def change_sponsor

  end

  private
  def require_payment
    redirect_to url_for(:controller => :charges , :action => :new) and return
  end

end
