class PlayersController < ApplicationController
  #show all the player's on our database
  def list
    @players = Person.all
  end

  #show a single player's profile based on passed in id
  def show
    @player_id = params[:id].to_i

    if @player_id == 0
      @player = Person.find(1)
      @player_id = 1
    else
      @player = Person.find(@player_id)
    end
  end

  def new
    #generate string for QR encoding: email, ticket type, tournament name, and datetime created.
    @qr_string = "#{@player.person.email}#{@player.ticket_type.name}#{player.tournament.name}#{Datetime.now}"
    
  end

  def create
    params.permit!

    @player = Player.new(params[:player])
    if @player.save
        # flash.now for to make the flash disappear after a while
        flash[:success] = 'You have sucessfully joined this tournament.'
    else
      # TODO:need to display te specific errors
      flash[:danger] = @player.errors.full_messages
    end
    redirect_to Tournament.find(params[:player][:tournament_id]) 
  end

  def edit
  end

  def update
  end

  def delete
  end

end
