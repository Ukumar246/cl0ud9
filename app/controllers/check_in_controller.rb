class CheckInController < ApplicationController
  def index 
  end

  #show all the player's on our database
  def list
    @tplayers = Person.all
    @pass_str = 'Pass this str'
  end

  def show
  	puts "Check In Controller..."
    
    @tourPlayers = Player.where(tournament_id:params[:id])
    #an_id = @tourPlayers[0].person_id;
    #@specificPlayer = Person.where(person_id:an_id)
    puts "Players who can sign up: #{@tourPlayers.length} & #{@tourPlayers}"

    puts @tourPlayer
    @avatar_link = "http://www.w3schools.com/w3css/img_avatar2.png"
  end
end
