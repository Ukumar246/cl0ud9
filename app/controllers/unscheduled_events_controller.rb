class UnscheduledEventsController < ApplicationController
	def new
		@noSchedEvent = UnscheduledEvent.new
	end

	def create
		@noSched_event = UnscheduledEvent.new(unscheduled_event_params)
		@noSched_event.save

		redirect_to url_for(:controller=>'tournaments', :action=>'organize', :id=>params[:unscheduled_event][:tournament_id])
	end

		def destroy
      @tournament = Tournament.find params[:tournament_id]
      @event = @tournament.unscheduled_events.find params[:id]
      @event.destroy
			redirect_to url_for(:controller=>'tournaments', :action=>'organize', :id=>@tournament.id)
   end

	private
	def unscheduled_event_params
		params.require(:unscheduled_event).permit(:description, :tournament_id)
	end
end
