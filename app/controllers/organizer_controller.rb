class OrganizerController < ApplicationController
  def new
	#load a partial view of the new organizer 
	
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
  
  def destroy 
    @organizer = Organizer.find(params[:id])
	@organizer.destroy
  end
  
end
