class OrganizerController < ApplicationController
  def new
	#load a partial view of the new organizer
	@person = Person.all
	render :partial=>'organizer/new'
  end

  def create

	#Check permissions

	organizer = Organizer.new
	organizer.person_id = params[:organizer][:person_id]
	organizer.tournament_id = params[:tournament_id]
	organizer.permissions = params[:organizer][:permission]

	organizer.save

	redirect_to :controller=>'tournaments', :action =>'organize', :id=>params[:tournament_id]
	end

  def update
    @organizer = Organizer.find(params[:organizer][:id])
    @organizer.permissions = params[:organizer][:permission]
	tournament_id = @organizer.tournament_id
	organizer.save

	redirect_to :controller=>'tournaments', :action =>'organize', :id=>tournament_id
  end

  def destroy
    @organizer = Organizer.find(params[:id])
	tournament_id = @organizer.tournament_id
	@organizer.destroy

	redirect_to :controller=>'tournaments', :action =>'organize', :id=>tournament_id
  end

  def update_admin_option_selection
    @person = People.where("Lower(email) LIKE ?", "%#{params[:email_value].downcase}%")

	respond do |format|
		format.js
	end
  end

end
