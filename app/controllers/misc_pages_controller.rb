class MiscPagesController < ApplicationController
  def show
    render template: "misc_pages/#{params[:misc_page]}"
  end  

end
