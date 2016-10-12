class PeopleController < ApplicationController
  def show
    @person = Person.find(params[:id])
  end

  def new
    @person = Person.new
  end

  def create
    #Really would need something here    
  end  
end
