class PeopleController < ApplicationController
  #show all the player's on our database
  def list
    @players = Person.all
    @people = Person.all
  end

  def index
  @people = Person.all
  @count = Person.count
  @person = Person.new
    #@tournaments.each do |t|
    # @addresses.push(get_golf_course_address(t))
    #end
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

      @tournaments_organizers = Tournament.where(id:tournaments_organizers)

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
end
