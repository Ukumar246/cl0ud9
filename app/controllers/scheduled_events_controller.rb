class ScheduledEventsController < ApplicationController
	def new
		@sched_event = ScheduledEvent.new
	end

	def create
		@sched_event = ScheduledEvent.new(scheduled_event_params)
		@sched_event.save

		redirect_to url_for(:controller=>'tournaments', :action=>'organize', :id=>params[:scheduled_event][:tournament_id])
	end

	def destroy
      @tournament = Tournament.find params[:tournament_id]
      @event = @tournament.scheduled_events.find params[:id]
      @event.destroy
			redirect_to url_for(:controller=>'tournaments', :action=>'organize', :id=>@tournament.id)
   end
	private
	def scheduled_event_params
		params.require(:scheduled_event).permit(:description, :startTime, :tournament_id)
	end
end
