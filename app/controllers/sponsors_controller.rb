class SponsorsController < ApplicationController
  #before_action :require_payment

  def new
    #Partial
  end

  def create
    params.permit!

    @sponsor = Sponsor.new(params[:sponsor])
    @sponsor.paid = false
    price = (Sponsorship.find(params[:sponsor][:sponsorship_id]).price * 100).to_i

    if @sponsor.save
      require_payment(price)
      # flash.now for to make the flash disappear after a while
      flash[:success] = 'You have sucessfully sponsored this tournament.'
      redirect_to Tournament.find(params[:sponsor][:tournament_id]) and return

    else
      # TODO:need to display te specific errors
      flash[:danger] = @sponsor.errors.full_messages
    end
    
    #redirect_to url_for(:controller => :charges , :action => :new,:sponsor_id => @sponsor.id,:sponsorship_id => @sponsor.sponsorship_id) and return
  end

  def change_sponsor

  end

  #private
  def require_payment(price)
    charge = Stripe::Charge.create(
      :amount => price,
      :description => 'Rails Stripe customer',
      :source => params[:stripeToken],
      :currency => 'CAD'
      )

      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to Tournament.find(params[:sponsor][:tournament_id])

        @sponsor.paid = true

  end

end
