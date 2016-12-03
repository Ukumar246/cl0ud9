class ErrorsController < ApplicationController

  def show
    status_code = params[:code] || 500
    flash[:danger] = "Status #{status_code}"
    render "404", status: status_code
  end

end