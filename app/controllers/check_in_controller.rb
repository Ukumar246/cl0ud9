class CheckInController < ApplicationController

  #show all the player's on our database
  def list
    @tplayers = Player.all
  end

  def show
    @tourPlayer = Player.where(tournament_id:1)
  end



  def show
  end
end
