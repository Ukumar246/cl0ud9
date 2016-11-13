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
    @player = Player.new
  end

  def create
    params.permit!

    @tournament = Tournament.find(params[:player][:tournament_id])
    @player = Player.new(params[:player])
    @numPlayersOnTicket = @player.ticket_type.numPlayers
    @numTickets = @player.numTickets.to_i
    @numPlayers = @numTickets * @numPlayersOnTicket
    if (@numPlayersOnTicket * @numTickets > @tournament.ticketsLeft)
      flash[:danger] = 'There are not enough tickets remaining to fill your order'
    else
        @newPlayers = Array.new(@numPlayers){|i| i=Player.new(params[:player])};
        @allPlayersValid = true
        Player.transaction do
          @newPlayers.each do |nP| 
            if not nP.save
              @allPlayersValid = false
              @errors = nP.errors.full_messages
              break
            end
          end
        end
        if not @allPlayersValid
          flash[:danger] = 'There was an error with your order: ' + @errors.to_s
        else
          GeneralMailer.ticket_confirmation_email(@newPlayers).deliver!
          # flash.now for to make the flash disappear after a while
          flash[:success] = 'You have successfully joined this tournament.'
          @tournament.ticketsLeft -= @numPlayers
          @tournament.save
        end
      
    end
    redirect_to @tournament
  end

  def edit
  end

  def update
  end

  def delete
  end

end
