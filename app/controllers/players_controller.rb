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

    @golf_course_people = GolfCoursePerson.where(person_id:@player_id)
    if @golf_course_people.size>0

      golf_courses = []
      print('@golf_course_people EXISTS!');
    #   need two tabs for this: golf courses && hosted tournaments
      @golf_course_people.each do |golf_course_person|
          golf_courses << golf_course_person.golf_course_id
      end

      @golf_courses = GolfCourse.where(id:golf_courses)
      @tournaments_golf_courses = Tournament.where(golf_course_id:golf_courses)

    end
    @organizers = Organizer.where(person_id:@player_id)
    if @organizers.size > 0

      tournaments_organizers = []
      print('@organizers EXISTS!');
      @organizers.each do |organizer|
        tournaments_organizers << organizer.tournament_id
      end

      @tournaments_organizers = Tournament.where(id:tournaments)

    end
    @players = Player.where(person_id:@player_id)
    if  @players.size > 0

      tournaments_players = []
      print('@players  EXISTS!');
      @players.each do |player|
        tournaments_players << player.tournament_id
      end

      @tournaments_players = Tournament.where(id:tournaments_players)

    end
    @sponsors = Sponsor.where(person_id:@player_id)
    if @sponsors.size > 0

      tournaments_sponsors = []
      @sponsors.each do |sponsor|
        tournaments_sponsors << sponsor.tournament_id
      end

      @tournaments_sponsors = Tournament.where(id:tournaments_sponsors)
    end
  end

  def new
    @player = Player.new
  end

  def create
    params.permit!
    @tournament = Tournament.find(params[:player][:tournament_id])
    @player = Player.new(params[:player])
    @player.paid = false
    @numPlayersOnTicket = @player.ticket_type.numPlayers
    @numTickets = @player.numTickets.to_i
    @numPlayers = @numTickets * @numPlayersOnTicket
    price = (@player.ticket_type.price * 100 *@numTickets).to_i
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
        assign_to_teams(@newPlayers, @tournament.id)
        require_payment(price)
        GeneralMailer.ticket_confirmation_email(@newPlayers).deliver!
        # flash.now for to make the flash disappear after a while
        flash[:success] = 'You have successfully joined this tournament.'
        @tournament.ticketsLeft -= @numPlayers
        @tournament.save
      end
    end
    puts "Player id: #{@player.id}"

    if @tournament.privateURL
      #redirect_to url_for(:controller => :charges , :action => :new, :player_id => @player.id, :sponsorshipType => @player.ticket_type) and return
      redirect_to url_for(:controller => :tournaments, :action => "private_url", :key => @tournament.private_url.key, :id => @tournament.id)
    else
      #redirect_to url_for(:controller => :charges , :action => :new, :player_id => @player.id, :sponsorshipType => @player.ticket_type) and return
      redirect_to @tournament
    end
    #redirect_to url_for(:controller => :charges , :action => :new,:sponsor_id => @sponsor.id,:sponsorshipType => @sponsor.sponsorshipType) and return
  end

  def edit
  end

  def update
  end

  def delete
  end

  def require_payment(price)
    charge = Stripe::Charge.create(
      :amount => price,
      :description => 'Rails Stripe customer',
      :source => params[:stripeToken],
      :currency => 'CAD'
      )

      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to Tournament.find(params[:player][:tournament_id])

        @player.paid = true
        @newPlayers.each do |p|
          p.paid = true
        end
  end

  private
  def assign_to_teams(newPlayers, tournament_id)
    numFullTeams = newPlayers.length / 4
    puts {"#numFullTeams"}
    newTeams = Array.new(numFullTeams){|i| i=Team.create(tournament_id: tournament_id, numPlayers: 4)}
    Team.transaction do
      if newTeams
        newTeams.each do |nt|
          nt.save
        end
      end
    end
    i = 0
    newTeams.each do |t|
      newPlayers[i..i+3].each do |p|
        p.team_id = t.id
        p.save
      end
      i+=4
    end

    i -= 3
    teams = Team.all
    remainingPlayers = newPlayers[i..(newPlayers.size - 1)]
    if not remainingPlayers.nil?
      newPlayers[i..(newPlayers.size - 1)].each do |p|
        team = teams.select {|t| t.numPlayers < 4}.first
        if team.nil?
          team = Team.new(tournament_id: tournament_id, numPlayers: 1)
          team.save
          teams = Team.all
        else
          team.numPlayers += 1
        end

        p.team_id = team.id
        p.save
      end
      Team.transaction do
        teams.each(&:save!)
      end
    end

  end

  

  # private
  #   def get_golf_courses
  #     golf_course_ids = []
  #     golf_course_people = GolfCoursePerson.find_by(person_id: @player_id)
  #     if golf_course_people != nil
  #       if golf_course_people.size > 1
  #         golf_course_people.each do |golf_course_person|
  #           golf_course_ids << golf_course_person.golf_course_id
  #         end
  #       else
  #         golf_course_ids << golf_course_people.golf_course_id
  #       end
  #       golf_courses = GolfCourse.find_by(golf_course_id: golf_course_ids)
  #
  #       return golf_courses
  #     end
  #
  #     return 0
  #
  #   end

end

