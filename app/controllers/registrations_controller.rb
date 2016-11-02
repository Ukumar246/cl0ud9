class RegistrationsController < ApplicationController
  def create
    @registration = Registration.new(registration_params)
    if @registrration.save
      redirect_to @registration.paypal_url(registration_path(@registration))
    else 
      render :new
  end

end
