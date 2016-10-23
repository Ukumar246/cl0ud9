class PlayerController < ApplicationController
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
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end

end
