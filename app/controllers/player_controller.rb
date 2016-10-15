class PlayerController < ApplicationController
  def profiles
    @global = Person.order(:fName).first(1)
    puts @global
  end
end
