class ChargesController < ApplicationController
  def new
     @sponsor = params[:sponsor_id]
     @sponsorship =  Sponsorship.find(params[:sponsorship_id])
     @amount = @sponsorship.price
  end

  def create
    customer = Stripe::Customer.create(
       :email => params[:stripeEmail],
       :source => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount => params[:charges][:amount],
      :description => 'Rails Stripe customer',
      :currency => 'CAD'
    )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to url_for(:controller => :tournaments, :action => :index)

    @sponsor = Sponsor.find(params[:charges][:sponsor_id])
    @sponsor.paid = true
    if @sponsor.save
      puts "saved!"
    end
  end
  
  #redirect_to url_for(:controller => :sponsors , :action => :new)
end
