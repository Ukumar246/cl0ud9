class CheckInController < ApplicationController
  def index 
  end

  #show all the player's on our database
  def list
    @tplayers = Player.all
    @pass_str = 'Pass this str'
  end

  def show
  	puts "Check In Controller..."
    @tourPlayer = Player.where(tournament_id:1)
    @avatar_link = "http://www.w3schools.com/w3css/img_avatar2.png"
    @players = Array[1, 2, 3, 4,5];
  end
end
